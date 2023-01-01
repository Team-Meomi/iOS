//
//  ListRequest.swift
//  idea
//
//  Created by 선민재 on 2022/12/20.
//

import Foundation

struct ListRequest: Codable {
    let Authorization: String
    
    init(_ Authorization: String) {
        self.Authorization = Authorization
    }
}
