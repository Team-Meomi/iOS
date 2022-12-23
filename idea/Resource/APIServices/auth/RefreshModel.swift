//
//  RefreshModel.swift
//  idea
//
//  Created by 선민재 on 2022/12/22.
//

import Foundation


struct RefreshModel: Codable {
    let data: RefreshResponse
}

struct RefreshResponse: Codable {
    let accessToken: String
    let refreshToken: String
    let expiredAt: String
}
