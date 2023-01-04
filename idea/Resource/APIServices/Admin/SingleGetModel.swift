//
//  CheckConModel.swift
//  idea
//
//  Created by 선민재 on 2023/01/02.
//

import Foundation

struct SingleGetModel: Codable {
    let list: [SingleGetResponse]
}

struct SingleGetResponse: Codable {
    let id: Int
    let stuNum: Int
    let name: String
}
