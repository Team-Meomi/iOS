//
//  DeleteRequest.swift
//  idea
//
//  Created by 선민재 on 2022/12/30.
//

import Foundation

struct DeleteRequest: Codable {
    let Authorization: String
    let id: Int
    
    init(_ Authorization: String,_ id:Int) {
        self.Authorization = Authorization
        self.id = id
    }
}
