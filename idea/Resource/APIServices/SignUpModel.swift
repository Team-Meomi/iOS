//
//  SignUpModel.swift
//  idea
//
//  Created by 선민재 on 2022/12/19.
//

import UIKit
import Foundation
import Moya


struct SignupModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: SignupResponse
}

struct SignupResponse: Codable {
    let email: String
}
