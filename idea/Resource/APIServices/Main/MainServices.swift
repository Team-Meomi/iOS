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
    case checkAudiovisual(param: CheckAudiovisualRequest, authorization: String)
    case checkHomebase(param: CheckHomebaseRequest, authorization: String)
}

extension MainServices: TargetType{
    
    public var baseURL: URL {
        return URL(string: GeneralAPI.baseURL)!
    }
    
    var path: String {
        switch self{
        case .getList:
            return "/study"
        case .checkAudiovisual:
            return "/study/audiovisual"
        case .checkHomebase:
            return "/study/homebase"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getList:
            return .get
        case .checkAudiovisual,
            .checkHomebase:
            return .post
        }
    }
    
    var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    var task: Moya.Task {
        switch self {
        case .getList:
            return .requestPlain

        case .checkHomebase(let param,_):
            return .requestParameters(parameters: [
                "date": param.date
            ], encoding: URLEncoding.queryString)

        case .checkAudiovisual(let param,_):
            return .requestParameters(parameters: [
                "date": param.date
            ], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .checkHomebase(_,let authorization):
            return["Content-Type" :"application/json","Authorization" : authorization]
        default:
            return["Content-Type" :"application/json"]
        }
    }
    
    
}
