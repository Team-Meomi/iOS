//
//  SearchRequest.swift
//  idea
//
//  Created by 선민재 on 2022/12/30.
//

import Foundation

struct SearchRequest: Codable {
    let Authorization: String
    let title: String
    let category: String
    
    init(_ Authorization: String,_ title:String, _ category: String) {
        self.Authorization = Authorization
        self.title = title
        self.category = category
    }
}
