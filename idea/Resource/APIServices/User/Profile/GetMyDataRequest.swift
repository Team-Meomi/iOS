//
//  GetMyDataRequest.swift
//  idea
//
//  Created by 선민재 on 2022/12/28.
//

import Foundation

struct GetMyDataRequest: Codable {
    let Authorization: String
    
    init(_ Authorization: String) {
        self.Authorization = Authorization
    }
}
