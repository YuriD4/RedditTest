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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
