//
//  Refresh.swift
//  idea
//
//  Created by 선민재 on 2022/12/22.
//

import UIKit
import Moya

extension UIViewController {
//    func success() {
//        @objc
//    }
//    func failure() {
//
//    }
    func Refresh() {
        let param = RefreshRequest.init(BaseVC.userData!.refreshToken)
        print(param)
        BaseVC.authProvider.request(.refresh(param: param)) {response in
            switch response {
            case let .success(result):
                do {
                    BaseVC.userData = try result.map(LoginResponse.self)
                } catch(let err) {
                    print(err.localizedDescription)
                }
                let statusCode = result.statusCode
                switch statusCode {
                case 200..<300:
//                    self.success()
                    break
                default:
//                    self.failure()
                    break
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
