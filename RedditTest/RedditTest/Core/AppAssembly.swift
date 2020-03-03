//
//  AppAssembly.swift
//  RedditTest
//
//  Created by Yuri Chukhlib on 01.03.2020.
//  Copyright © 2020 Yuri Chukhlib. All rights reserved.
//

import UIKit

final class AppAssembly {
    let coreComponents: CoreComponents
    
    init(coreComponents: CoreComponents) {
        self.coreComponents = coreComponents
    }
}

extension AppAssembly {
    func generalViewController(navigator: Navigator) -> UINavigationController {
        let presenter = GeneralPresenterImpl(apiManager: coreComponents.apiManager, navigator: navigator)
        let vc = GeneralViewController(presenter: presenter)
        presenter.setupOutput(vc)
        return UINavigationController(rootViewController: vc)
    }
}
