//
//  LoginRequest.swift
//  idea
//
//  Created by 선민재 on 2022/12/19.
//

import Foundation


struct LoginRequest: Codable {
    var email: String
    var password: String
    
    init(_ id: String,_ password: String) {
        self.email = id
        self.password = password
    }
}
