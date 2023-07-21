//
//  Post.swift
//  Overreacted
//
//  Created by Ali Saeedifar on 7/20/23.
//

import Foundation

struct Post: Decodable, Identifiable {
    let id: Int
    let userId: Int
    let title: String
    let publishedAt: Date
    let body: String
    
    
    enum CodingKeys: CodingKey {
        case id
        case userId
        case title
        case publishedAt
        case body
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.userId = try container.decode(Int.self, forKey: .userId)
        self.title = try container.decode(String.self, forKey: .title)
        self.publishedAt = Date().getDayBefore(count: self.id)
        self.body = try container.decode(String.self, forKey: .body)
    }
}


