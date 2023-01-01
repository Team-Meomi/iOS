//
//  CreateConRequest.swift
//  idea
//
//  Created by 선민재 on 2022/12/26.
//

import Foundation

struct CreateRequest: Codable {
    let Authorization: String
    let title: String // 제목
    let content: String // 설명
    let category: String  // iOS, FE
    let date: String // 2022-12-14
    let maxCount: Int // 스터디는 고정 5
    let studyType: String // 컨퍼런스, 스터디
    
    init(_ Authorization: String,_ title: String,_ content:String,_ category:String,_ date: String,_ maxCount: Int,_ studyType: String) {
        self.Authorization = Authorization
        self.title = title
        self.content = content
        self.category = category
        self.date = date
        self.maxCount = maxCount
        self.studyType = studyType
    }
}
