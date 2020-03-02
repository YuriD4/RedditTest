//
//  Navigator.swift
//  RedditTest
//
//  Created by Yuri Chukhlib on 02.03.2020.
//  Copyright © 2020 Yuri Chukhlib. All rights reserved.
//

import UIKit

protocol Navigator {
    
    
}

final class NavigatorImpl: Navigator {

    let window: UIWindow?
    
    var appAssembly: AppAssembly! {
        didSet {
            setupInitialViewController()
        }
    }

    init(window: UIWindow?) {
        self.window = window
    }
    
    private func setupInitialViewController() {
        //window?.rootViewController = appAssembly.onBoardingController(navigator: self)
        self.window?.makeKeyAndVisible()
    }
    
}

