//
//  CoreComponents.swift
//  RedditTest
//
//  Created by Yuri Chukhlib on 01.03.2020.
//  Copyright © 2020 Yuri Chukhlib. All rights reserved.
//

import Foundation

final class CoreComponents {
    
    private let navigator: Navigator
    private let factory = CoreComponentsFactory()
    private let dependency: CoreComponentsDependency
    
    init(navigator: Navigator) {
        self.navigator = navigator
        self.dependency = CoreComponentsDependency()
    }
    
}

