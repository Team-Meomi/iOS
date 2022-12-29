//
//  UserWritten.swift
//  idea
//
//  Created by 선민재 on 2022/12/28.
//

import UIKit
import Moya

extension ProfileViewController {
    func successUserWritten() {
        print("success")
    }
    
    func failureUserWritten() {
        let failureAlert = UIAlertController(title: nil, message: "사용자를 찾을 수 없습니다.", preferredStyle: .alert)
        let failureAction = UIAlertAction(title: "확인", style: .cancel) {(action) in
            self.viewModel.pushLogin()
        }
        failureAlert.addAction(failureAction)
        self.present(failureAlert, animated: true, completion: nil)
        print("failure")
    }
    
    private func accessTokenError() {
        Refresh()
        self.userWritten()
    }
    
    func userWritten() {
        BaseVC.profileProvider.request(.userWritten(id: BaseVC.decodedMyData?.id ?? 0, authorization: BaseVC.userData!.accessToken)) {response in
            switch response {
            case let .success(result):
                let responseData = result.data
                do {
                    BaseVC.decodedUserWritten = try JSONDecoder().decode([UserWrittenResponse].self, from: responseData)
                } catch(let err) {
                    print(err.localizedDescription)
                    print(String(describing: err))
                }
                let statusCode = result.statusCode
                switch statusCode {
                case 200..<300:
                    self.successUserWritten()
                case 403:
                    self.accessTokenError()
                default:
                    self.failureUserWritten()
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
