//
//  Join.swift
//  idea
//
//  Created by 선민재 on 2022/12/30.
//

import UIKit
import Moya

extension DetailViewController {
    
    private func joinSuccess() {
        let joinSuccessAlert = UIAlertController(title: nil, message: "신청이 완료되었습니다.", preferredStyle: .alert)
        let joinSuccessction = UIAlertAction(title: "확인", style: .cancel) {(action) in
            self.viewModel.pushMain()
        }
        joinSuccessAlert.addAction(joinSuccessction)
        self.present(joinSuccessAlert, animated: true, completion: nil)
    }
    
    private func failure() {
        let faliureAlert = UIAlertController(title: nil, message: "유저를 찾을 수 없습니다.", preferredStyle: .alert)
        let faliureAction = UIAlertAction(title: "확인", style: .cancel) {(action) in
            self.viewModel.pushIntro()
        }
        faliureAlert.addAction(faliureAction)
        self.present(faliureAlert, animated: true, completion: nil)
    }
    
    private func accessTokenError() {
        Refresh()
        self.join()
    }
    
    func join() {
        BaseVC.detailProvider.request(.join(id: BaseVC.decodedDetailData!.id, authorization: BaseVC.userData!.accessToken)) {response in
            switch response {
            case let .success(result):
                let statusCode = result.statusCode
                switch statusCode {
                case 200..<300:
                    self.joinSuccess()
                case 403:
                    self.accessTokenError()
                default:
                    self.failure()
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
