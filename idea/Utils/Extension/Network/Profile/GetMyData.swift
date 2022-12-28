//
//  GetMyData.swift
//  idea
//
//  Created by 선민재 on 2022/12/28.
//

import UIKit
import Moya

extension ProfileViewController {
    func successList() {
        print("success")
    }
    
    func failureList() {
        print("failure")
    }
    
    func getMyData() {
        let param = GetMyDataRequest.init(BaseVC.userData!.accessToken)
        print(param)
        BaseVC.profileProvider.request(.getMyData(authorization: BaseVC.userData!.accessToken)) {response in
            switch response {
            case let .success(result):
                let responseData = result.data
                do {
                    BaseVC.decodedMyData = try JSONDecoder().decode([GetMyDataResponse].self, from: responseData)
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
