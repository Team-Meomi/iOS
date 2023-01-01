//
//  CreateStuRequest.swift
//  idea
//
//  Created by 선민재 on 2022/12/23.
//

import Foundation

struct CheckAudiovisualRequest: Codable {
    let Authorization: String
    let date: String
    
    init(_ Authorization: String,_ date: String) {
        self.Authorization = Authorization
        self.date = date
    }
}
