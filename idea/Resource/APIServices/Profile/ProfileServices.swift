//
//  ProfileServices.swift
//  idea
//
//  Created by 선민재 on 2022/12/28.
//

import Foundation
import Moya


enum ProfileServices{
    case getMyData(authorization: String)
    case userWritten(id:Int,authorization: String)
    case userJoined(id:Int,authorization:String)
}

extension ProfileServices: TargetType{
    
    public var baseURL: URL {
        return URL(string: GeneralAPI.baseURL)!
    }
    
    var path: String {
        switch self{
        case .getMyData:
            return "/"
        case .userWritten(let id,_):
            return "/written/\(id)"
        case .userJoined(let id,_):
            return "/joined/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMyData, .userWritten, .userJoined:
            return .get
        }
    }
    
    var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    var task: Moya.Task {
        switch self {
        case .getMyData, .userWritten, .userJoined:
            return .requestPlain
        }
    }
        
    var headers: [String : String]? {
        switch self {
        case .getMyData(let authorization),.userWritten(_, let authorization), .userJoined(_, let authorization):
            return["Content-Type" :"application/json","Authorization" : authorization]
        default:
            return["Content-Type" :"application/json"]
        }
    }
}

