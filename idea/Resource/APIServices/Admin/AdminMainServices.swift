//
//  AdminMainServices.swift
//  idea
//
//  Created by 선민재 on 2023/01/02.
//

import Foundation
import Moya


enum AdminMainServices{
    case checkCon(authorization: String)
    case checkStu(authorization: String)
}

extension AdminMainServices: TargetType{
    
    public var baseURL: URL {
        return URL(string: GeneralAPI.adminBaseURL)!
    }
    
    var path: String {
        switch self{
        case .checkCon:
            return "/study/audiovisual"
        case .checkStu:
            return "/study/homebase"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .checkCon,.checkStu:
            return .get
        }
    }
    
    var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    var task: Moya.Task {
        switch self {
        case .checkCon, .checkStu:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .checkCon(let authorization), .checkStu(let authorization):
            return["Content-Type" :"application/json","Authorization" : authorization]
        default:
            return["Content-Type" :"application/json"]
        }
    }
    
    
}
