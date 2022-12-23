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
    case checkAudiovisual(param: CheckAudiovisualRequest, Authorization: String)
    case checkHomebase(param: CheckHomebaseRequest, Authorzation: String)
}

extension MainServices: TargetType{
    
    public var baseURL: URL {
        return URL(string: GeneralAPI.baseURL)!
    }
    
    var path: String {
        switch self{
        case .getList:
            return "/api/v1/study"
        case .checkAudiovisual:
            return "/api/v1/study/audiovisual"
        case .checkHomebase:
            return "/api/v1/study/homebase"
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
        case .checkHomebase(let CheckHomebaseRequest, _):
            return .requestJSONEncodable(CheckHomebaseRequest)
        case .checkAudiovisual(let CheckAudiovisualRequest,_):
            return .requestJSONEncodable(CheckAudiovisualRequest)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .checkHomebase(_, let Authorzation):
            return["Content-Type" :"application/json","Authorzation" : Authorzation]
        default:
            return["Content-Type" :"application/json"]
        }
    }
    
    
}
