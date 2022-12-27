//
//  List.swift
//  idea
//
//  Created by 선민재 on 2022/12/27.
//

import UIKit
import Moya

extension MainViewController {
    func successList() {
        print("success")
    }
    
    func failureList() {
        print("failure")
    }
    
    func List() {
        let param = ListRequest.init(BaseVC.userData!.accessToken)
        print(param)
        BaseVC.mainProvider.request(.getList(authorization: BaseVC.userData!.accessToken)) {response in
            switch response {
            case let .success(result):
                let responseData = result.data
                do {
                    BaseVC.decodedData = try JSONDecoder().decode([ListResponse].self, from: responseData)
                } catch(let err) {
                    print(err.localizedDescription)
                }
                let statusCode = result.statusCode
                switch statusCode {
                case 200..<300:
                    self.successList()
                default:
                    self.failureList()
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
