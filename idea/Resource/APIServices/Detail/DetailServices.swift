//
//  DetailServices.swift
//  idea
//
//  Created by 선민재 on 2022/12/29.
//

import Foundation
import Moya


enum DetailServices{
    case getDetail(id: Int,authorization: String)
    case join(id: Int, authorization: String)
    case delete(id: Int, authorization: String)
}

extension DetailServices: TargetType{
    
    public var baseURL: URL {
        return URL(string: GeneralAPI.userBaseURL)!
    }
    
    var path: String {
        switch self{
        case .getDetail(let id, _), .join(let id, _):
            return "/study/\(id)"
        case .delete(let id,_):
            return "/study/cancel/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getDetail:
            return .get
        case .join:
            return .post
        case .delete:
            return .delete
        }
    }
    
    var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    var task: Moya.Task {
        switch self {
        case .getDetail, .join, .delete:
            return .requestPlain
        }
    }
        
    var headers: [String : String]? {
        switch self {
        case .getDetail(_,let authorization), .join(_,let authorization), .delete(_,let authorization):
            return["Content-Type" :"application/json","Authorization" : authorization]
        default:
            return["Content-Type" :"application/json"]
        }
    }
}

