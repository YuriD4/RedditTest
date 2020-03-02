//
//  StateContainerView.swift
//  RedditTest
//
//  Created by Yuri Chukhlib on 02.03.2020.
//  Copyright © 2020 Yuri Chukhlib. All rights reserved.
//

import UIKit

protocol StateView where Self: UIView {
    func show()
    func hide()
}

final class StateContainerView: UIView {
    
    var contentView: UIView?
    
    private enum LocalConstants {
        static var defaultErrorMessage = "Упс. Попробуйте загрузить позже"
        static var defaultEmptyMessage = "Еще нет данных для отображения"
    }
    
    private var errorView: StateView?
    private var loadingView: StateView?
    private var emptyView: StateView?
    
    private var errorMessage: String = LocalConstants.defaultErrorMessage
    private var emptyMessage: String = LocalConstants.defaultEmptyMessage
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = .clear
        createStateViews()
    }
    
    private func createStateViews() {
        guard errorView == nil, loadingView == nil, emptyView == nil else { return }
        errorView = ErrorView(frame: self.frame)
        loadingView = LoaderView(frame: self.frame)
        emptyView = EmptyView(frame: self.frame)
        
        initialSetup(for: emptyView)
        initialSetup(for: loadingView)
        initialSetup(for: errorView)
    }
        
    private func initialSetup(for stateView: StateView?) {
        if let wrappedView = stateView {
            wrappedView.hide()
            addSubview(wrappedView)
            sendSubviewToBack(wrappedView)
            stateView?.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                wrappedView.leftAnchor.constraint(equalTo: self.leftAnchor),
                wrappedView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                wrappedView.rightAnchor.constraint(equalTo: self.rightAnchor),
                wrappedView.topAnchor.constraint(equalTo: self.topAnchor)
            ])
        }
    }
    
    private func hideAllStateViews() {
        subviews
            .compactMap { $0 as? StateView }
            .forEach { $0.hide() }
    }
}

extension StateContainerView {
    func add(to parentView: UIView) {
        parentView.addSubview(self)
        parentView.sendSubviewToBack(self)

        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leftAnchor.constraint(equalTo: parentView.leftAnchor),
            bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
            rightAnchor.constraint(equalTo: parentView.rightAnchor),
            topAnchor.constraint(equalTo: parentView.topAnchor)
        ])
    }
    
    func setDefaultErrorMessage(_ message: String) {
        errorMessage = message
        (errorView as? ErrorView)?.configure(with: errorMessage)
    }
    
    func setDefaultEmptyMessage(_ message: String) {
        emptyMessage = message
        (emptyView as? EmptyView)?.configure(with: emptyMessage)
    }
    
    func configureViews<T: Any>(with state: ListState<T>) {
        switch state {
        case .loading:
            loadingView?.show()
            errorView?.hide()
            emptyView?.hide()
        case .error(let error):
            loadingView?.hide()
            emptyView?.hide()
            if let localizedError = error {
                (errorView as? ErrorView)?.configure(with: localizedError)
                errorView?.show()
            }
        case .empty:
            loadingView?.hide()
            errorView?.hide()
            (emptyView as? EmptyView)?.configure(with: emptyMessage)
            emptyView?.show()
        default:
            hideAllStateViews()
        }
    }
}

