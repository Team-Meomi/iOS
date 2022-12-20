//
//  ListServices.swift
//  idea
//
//  Created by 선민재 on 2022/12/20.
//

import Foundation
import Moya


enum MainServices{
    case getList
}

extension MainServices: TargetType{
    
    public var baseURL: URL {
        return URL(string: GeneralAPI.baseURL)!
    }
    
    var path: String {
        switch self{
        case .getList:
            return "/api/v1/user/mainpage"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getList:
            return .get
        }
    }
    
    var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    var task: Moya.Task {
        switch self {
        case .getList:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return["Content-Type" :"application/json"]
        }
    }
    
    
}
