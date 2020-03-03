//
//  Post.swift
//  RedditTest
//
//  Created by Yuri Chukhlib on 02.03.2020.
//  Copyright © 2020 Yuri Chukhlib. All rights reserved.
//

import Foundation

struct Post: Decodable {
    
    var id: String
    var title: String
    var author: String
    var thumbnailLink: URL?
    var originalLink: URL?
    var numberOfComments: Int
    var creationDate: Date

    enum CodingKeys: String, CodingKey {
        case data
    }
    
    enum NestedCodingKeys: String, CodingKey {
        case name
        case title
        case author
        case thumbnail
        case url
        case numberOfComments = "num_comments"
        case created
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let nestedContainer = try container.nestedContainer(keyedBy: NestedCodingKeys.self, forKey: .data)
        
        id = try nestedContainer.decode(String.self, forKey: .name)
        title = try nestedContainer.decode(String.self, forKey: .title)
        author = try nestedContainer.decode(String.self, forKey: .author)
        thumbnailLink = try nestedContainer.decodeIfPresent(URL.self, forKey: .thumbnail)
        originalLink = try nestedContainer.decodeIfPresent(URL.self, forKey: .url)
        numberOfComments = try nestedContainer.decode(Int.self, forKey: .numberOfComments)
        creationDate = try nestedContainer.decode(Date.self, forKey: .created)
    }
}

