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
    case initial(items: [T], hasMore: Bool)
    case loadedMore(items: [T], hasMore: Bool)
    case error(Error?)
    case empty

    var hasMore: Bool {
        switch self {
        case .loadedMore(_, let hasMore): return hasMore
        case .initial(_, let hasMore): return hasMore
        default: return false
        }
    }
}
