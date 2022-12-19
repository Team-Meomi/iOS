//
//  SignUpRequest.swift
//  idea
//
//  Created by 선민재 on 2022/12/19.
//

import Foundation


struct SignUpRequest: Codable {
    var email: String
    var password: String
    var name: String
    var strNum: Int
    
    
    init(_ id: String,_ password: String,_ name: String,_ strNum:Int) {
        self.email = id
        self.password = password
        self.name = name
        self.strNum = strNum
    }
}
