//
//  RefreshRequest.swift
//  idea
//
//  Created by 선민재 on 2022/12/22.
//

import Foundation

struct RefreshRequest: Codable {
    let RefreshToken: String
    
    init(_ RefreshToken: String) {
        self.RefreshToken = RefreshToken
    }
}
