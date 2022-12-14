//
//  GetMyData.swift
//  idea
//
//  Created by 선민재 on 2022/12/28.
//

import Foundation


struct GetMyDataModel: Codable {
    let data: GetMyDataResponse
}

struct GetMyDataResponse: Codable {
    let id: Int
    let name: String
    let stuNum: Int
}
