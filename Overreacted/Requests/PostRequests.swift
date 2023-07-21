//
//  PostRequests.swift
//  Overreacted
//
//  Created by Ali Saeedifar on 7/20/23.
//

import Foundation
import Combine

protocol PostRequestProtocl {
    func fetchPosts() -> Future<[Post], Error>
}

struct PostRequest: PostRequestProtocl {
    func fetchPosts() -> Future<[Post], Error> {
        return NetworkManager.shared.getData(urlString: "/posts")
    }
}
