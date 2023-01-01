//
//  ListModel.swift
//  idea
//
//  Created by 선민재 on 2022/12/20.
//

import Foundation

struct ListModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: ListResponse
}

struct ListResponse: Codable {
    let id: Int
    let title: String
    let category: String
    let date: String
    let type: String
}
