//
//  PhotosModel.swift
//  HackerKernelInterview
//
//  Created by apple on 16/03/21.
//

import Foundation

struct PhotosModel: Codable {
    let albumID, id: Int
    let title: String
    let url, thumbnailURL: String
    
    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }
}
