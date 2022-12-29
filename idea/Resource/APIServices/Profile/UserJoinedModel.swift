//
//  UserJoinedModel.swift
//  idea
//
//  Created by 선민재 on 2022/12/29.
//

import Foundation


struct UserJoinedModel: Codable {
    let data: UserJoinedResponse
}

struct UserJoinedResponse: Codable {
    let id: Int
    let title: String
    let category: String
    let date: String
    let type: String
}
