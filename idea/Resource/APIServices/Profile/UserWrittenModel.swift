//
//  UserWrittenModel.swift
//  idea
//
//  Created by 선민재 on 2022/12/28.
//

import Foundation


struct UserWrittenModel: Codable {
    let data: UserWrittenResponse
}

struct UserWrittenResponse: Codable {
    let id: Int
    let title: String
    let category: String
    let date: String
    let type: String
}
