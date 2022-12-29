//
//  DetailModel.swift
//  idea
//
//  Created by 선민재 on 2022/12/29.
//

import Foundation


struct GetDetailModel: Codable {
    let data: GetDetailResponse
}

struct GetDetailResponse: Codable {
    let id: Int
    let title: String
    let content: String
    let date: String
    let studytype: String
    let isMine: Bool
    let isStatus: Bool
    let writer: Writer
    let count: Count
    let list: [SingleApplier]

    struct Writer: Codable {
        let id: Int
        let stuNum: Int
        let name: String
    }
    struct Count: Codable {
        let count: Int
        let maxCount: Int
    }
    struct SingleApplier: Codable {
        let id: Int
        let stuNum: Int
        let name: String
    }
}
