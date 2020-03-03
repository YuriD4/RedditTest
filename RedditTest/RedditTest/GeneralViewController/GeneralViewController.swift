//
//  GeneralViewController.swift
//  RedditTest
//
//  Created by Yuri Chukhlib on 02.03.2020.
//  Copyright © 2020 Yuri Chukhlib. All rights reserved.
//

import UIKit

protocol GeneralViewControllerInput: class {
    func handleStateChange(_ state: ListState<PostCellModel>)
}

class GeneralViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private let stateView = StateContainerView()
    private let presenter: GeneralPresenter
    private var cellModels: [PostCellModel] = []
    
    private let refreshControl = UIRefreshControl()
    
    private enum LocalConstants {
        static let estimatedRowHeight: CGFloat = 100
    }
    
    // MARK: - Init
    init(presenter: GeneralPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.getPosts()
    }
}

private extension GeneralViewController {
    func setupUI() {
        stateView.add(to: view)
        title = "Main"
        setupTableView()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        view.backgroundColor = UIColor.lightGray
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = LocalConstants.estimatedRowHeight
        
        tableView.register(cellType: PostCell.self, bundle: .main)
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(didRereshData(_:)), for: .valueChanged)
    }
    
    @objc private func didRereshData(_ sender: Any) {
        presenter.getPosts()
    }
    
    private func handleViewTap(originalURL: URL?) {
        presenter.didSelect(originalURL)
    }
}

// MARK: - table view extension
extension GeneralViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentItem = cellModels[indexPath.row]
        
        return tableView
               .dequeueReusableCell(ofType: PostCell.self, at: indexPath)
               .configure(with: currentItem)
               .onTap(callback: handleViewTap)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRowIndex = cellModels.count - 1
        
        if indexPath.row == lastRowIndex {
            presenter.getNewItems()
        }
    }
}

// MARK: - input
extension GeneralViewController: GeneralViewControllerInput {
    func handleStateChange(_ state: ListState<PostCellModel>) {
        stateView.configureViews(with: state)
        switch state {
        case .error, .empty:
            cellModels = []
            tableView.reloadData()
        case .initial(let newItems):
            cellModels = newItems
            refreshControl.endRefreshing()
            tableView.reloadData()
        case .loadedMore(items: let newItems):
            cellModels = newItems
            tableView.reloadData()
        default: break
        }
    }
}
