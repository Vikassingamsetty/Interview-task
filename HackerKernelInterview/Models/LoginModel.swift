//
//  LoginModel.swift
//  HackerKernelInterview
//
//  Created by apple on 17/03/21.
//

import Foundation

struct LoginModel: Codable {
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case token
    }
}

struct LoginModel1: Codable {
    let error: String
    
    enum CodingKeys: String, CodingKey {
        case error
    }
}
