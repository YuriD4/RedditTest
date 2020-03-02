//
//  AppDelegate.swift
//  RedditTest
//
//  Created by Yuri Chukhlib on 01.03.2020.
//  Copyright © 2020 Yuri Chukhlib. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var navigator: NavigatorImpl!
    private var appAssembly: AppAssembly!
    private var coreComponents: CoreComponents!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Setup window and navigator
        let window = UIWindow(frame: UIScreen.main.bounds)
        navigator = NavigatorImpl(window: window)
        
        // Setup core components
        coreComponents = CoreComponents(navigator: navigator)
        appAssembly = AppAssembly(coreComponents: coreComponents)
        navigator.appAssembly = appAssembly
        
        return true
    }
}

