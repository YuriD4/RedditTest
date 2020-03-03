//
//  PostCellModel.swift
//  RedditTest
//
//  Created by Yuri Chukhlib on 02.03.2020.
//  Copyright © 2020 Yuri Chukhlib. All rights reserved.
//

import Foundation

class PostCellModel {

    var id: String
    var title: String
    var authorName: String
    var createdTime: String
    var numberOfComments: String
    var thumbnailURL: URL?
    var originalURL: URL?
    
    init(post: Post) {
        id = post.id
        title = post.title
        authorName = "автор - \(post.author)"
        thumbnailURL = post.thumbnailLink
        originalURL = post.originalLink
        numberOfComments = "\(post.numberOfComments) комментариев"
        
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        let output = formatter.localizedString(for: post.creationDate, relativeTo: Date())

        createdTime = output
    }
}
