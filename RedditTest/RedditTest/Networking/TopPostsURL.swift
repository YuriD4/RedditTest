//
//  TopPostsURL.swift
//  RedditTest
//
//  Created by Yuri Chukhlib on 02.03.2020.
//  Copyright © 2020 Yuri Chukhlib. All rights reserved.
//

import UIKit

extension URL {
    static func topPosts(lastId: String? = nil) -> URL? {
        let urlComponents = NSURLComponents()
        urlComponents.scheme = "https";
        urlComponents.host = "reddit.com";
        urlComponents.path = "/top/.json";
      
        var params: [URLQueryItem] = []
        
        let perPage = URLQueryItem(name: "limit", value: "10")
        params.append(perPage)
        
        if let lastId = lastId {
            let lastId = URLQueryItem(name: "after", value: lastId)
            params.append(lastId)
        }
        
        urlComponents.queryItems = params
      
        return urlComponents.url
    }
}
