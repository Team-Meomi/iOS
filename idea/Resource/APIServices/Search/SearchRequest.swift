//
//  SearchRequest.swift
//  idea
//
//  Created by 선민재 on 2022/12/30.
//

import Foundation

struct SearchRequest: Codable {
    let Authorization: String
    let keyword: String
    let category: String
    
    init(_ Authorization: String,_ keyword:String, _ category: String) {
        self.Authorization = Authorization
        self.keyword = keyword
        self.category = category
    }
}
