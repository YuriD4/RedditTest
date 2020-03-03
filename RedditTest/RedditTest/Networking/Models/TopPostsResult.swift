//
//  TopPostsResult.swift
//  RedditTest
//
//  Created by Yuri Chukhlib on 02.03.2020.
//  Copyright © 2020 Yuri Chukhlib. All rights reserved.
//

import Foundation

struct TopPostsResult: Decodable {
    let posts: [Post]

    private enum CodingKeys: String, CodingKey {
        case data
    }
    
    private struct Posts: Decodable {
        let children: [Post]
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.posts = try container.decode(Posts.self, forKey: .data).children
    }
}
