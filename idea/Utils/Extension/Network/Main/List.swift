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
        let failureListAlert = UIAlertController(title: nil, message: "사용자를 찾을 수 없습니다.", preferredStyle: .alert)
        let failureListAction = UIAlertAction(title: "확인", style: .cancel) {(action) in
            self.viewModel.pushLogin()
        }
        failureListAlert.addAction(failureListAction)
        self.present(failureListAlert, animated: true, completion: nil)
        print("failure")
    }
    private func accessTokenError() {
        Refresh()
        self.List()
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
                case 403:
                    self.accessTokenError()
                default:
                    self.failureList()
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
