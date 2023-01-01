//
//  CheckConRequest.swift
//  idea
//
//  Created by 선민재 on 2023/01/02.
//

import Foundation

struct CheckConRequest: Codable {
    let Authorization: String
    
    init(_ Authorization: String) {
        self.Authorization = Authorization
    }
}
