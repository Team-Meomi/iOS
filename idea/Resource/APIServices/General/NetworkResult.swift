//
//  NetworkResult.swift
//  idea
//
//  Created by 선민재 on 2022/12/16.
//

import Foundation


enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
