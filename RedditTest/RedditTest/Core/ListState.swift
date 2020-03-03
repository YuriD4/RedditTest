//
//  ListState.swift
//  RedditTest
//
//  Created by Yuri Chukhlib on 02.03.2020.
//  Copyright © 2020 Yuri Chukhlib. All rights reserved.
//

import Foundation

enum ListState<T> {
    case loading
    case initial(items: [T])
    case loadedMore(items: [T])
    case error(Error?)
    case empty
}
