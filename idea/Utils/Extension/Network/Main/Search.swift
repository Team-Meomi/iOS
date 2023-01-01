//
//  Search.swift
//  idea
//
//  Created by 선민재 on 2022/12/30.
//

import UIKit
import Moya

extension SearchViewController {
    func successList() {
        print("success")
        print()
    }
    
    func failureList() {
        let failureListAlert = UIAlertController(title: nil, message: "사용자를 찾을 수 없습니다.", preferredStyle: .alert)
        let failureListAction = UIAlertAction(title: "확인", style: .cancel) {(action) in
//            self.viewModel.pushLogin()
        }
        failureListAlert.addAction(failureListAction)
        self.present(failureListAlert, animated: true, completion: nil)
        print("failure")
    }
    private func accessTokenError() {
        Refresh()
        self.search()
    }
    
    func search() {
        let param = SearchRequest.init(BaseVC.userData!.accessToken, searchTextField.text ?? "",BaseVC.searchMajor)
        print(param)
        BaseVC.mainProvider.request(.search(param: param, authorization: BaseVC.userData!.accessToken)) {response in
            switch response {
            case let .success(result):
                let responseData = result.data
//                print(String(data: responseData, encoding: .utf8))
                do {
//                    BaseVC.searchDecoedeData = try JSONDecoder().decode([SearchResponse].self, from: responseData)
//                    BaseVC.searchDecoedeData = try().decode([SearchResponse].self, from: responseData)
                } catch(let err) {
                    print(err.localizedDescription)
                    print(String(describing: err))
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
