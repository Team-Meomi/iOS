//
//  UserJoinedRequest.swift
//  idea
//
//  Created by 선민재 on 2022/12/29.
//

import Foundation

struct UserJoinedRequest: Codable {
    let Authorization: String
    let userId: Int
    
    init(_ Authorization: String,_ userId: Int) {
        self.Authorization = Authorization
        self.userId = userId
    }
}
