//
//  SearchModel.swift
//  idea
//
//  Created by 선민재 on 2022/12/30.
//

import Foundation


struct SearchModel: Codable {
    let data: SearchResponse
}

struct SearchResponse: Codable {
    let id: Int
    let title: String
    let category: String
    let date: String
    let type: String
}
