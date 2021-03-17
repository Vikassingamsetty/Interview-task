//
//  PostsModel.swift
//  HackerKernelInterview
//
//  Created by apple on 16/03/21.
//

import Foundation

struct PostsModel: Codable {
    let userID, id: Int?
    let title, body: String?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}
