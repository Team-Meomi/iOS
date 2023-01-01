//
//  UserWrittenRequest.swift
//  idea
//
//  Created by 선민재 on 2022/12/28.
//

import Foundation

struct UserWrittenRequest: Codable {
    let Authorization: String
    let userId: Int
    
    init(_ Authorization: String,_ userId: Int) {
        self.Authorization = Authorization
        self.userId = userId
    }
}
