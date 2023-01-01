//
//  ListServices.swift
//  idea
//
//  Created by 선민재 on 2022/12/20.
//

import Foundation
import Moya


enum MainServices{
    case getList(authorization: String)
    case checkAudiovisual(param: CheckAudiovisualRequest, authorization: String)
    case checkHomebase(param: CheckHomebaseRequest, authorization: String)
    case create(param:CreateRequest, authorization: String)
    case search(param:SearchRequest, authorization: String)
}

extension MainServices: TargetType{
    
    public var baseURL: URL {
        return URL(string: GeneralAPI.userBaseURL)!
    }
    
    var path: String {
        switch self{
        case .getList,.create:
            return "/study/"
        case .checkAudiovisual:
            return "/study/audiovisual"
        case .checkHomebase:
            return "/study/homebase"
        case .search:
            return "/study/search"
        } 
    }
    
    var method: Moya.Method {
        switch self {
        case .getList, .search:
            return .get
        case .checkAudiovisual,
            .checkHomebase,
            .create:
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
        case .search(let param, _):
            return .requestParameters(parameters: [
                "title": param.title,
                "category": param.category], encoding: URLEncoding.queryString)
        case .create(let param,_):
            return .requestJSONEncodable(param)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .checkHomebase(_,let authorization), .checkAudiovisual(_, authorization: let authorization)
            ,.create(_ , let authorization),.getList(let authorization), .search(_, let authorization):
            return["Content-Type" :"application/json","Authorization" : authorization]
        default:
            return["Content-Type" :"application/json"]
        }
    }
    
    
}
