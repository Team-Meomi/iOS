//
//  CheckAudiovisual.swift
//  idea
//
//  Created by 선민재 on 2022/12/23.
//

import Foundation
import Moya
import UIKit

extension CreateConViewController{
    func success() {
        print(dateFormatter.string(from: datePicker.date))
    }
    
    func cantborrow() {
        let cantborrowAlert = UIAlertController(title: nil, message: "이용할 수 없는 날짜입니다", preferredStyle: .alert)
        let cantborrowAction = UIAlertAction(title: "확인", style: .cancel) {(action) in
        }
        cantborrowAlert.addAction(cantborrowAction)
        self.present(cantborrowAlert, animated: true, completion: nil)
        print("cantborrow")
    }
    
    private func accessTokenError() {
        Refresh()
        self.checkAudiovisual()
    }
    
    func checkAudiovisual() {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let param = CheckHomebaseRequest.init(BaseVC.userData!.accessToken, date)
        print(param)
        BaseVC.mainProvider.request(.checkHomebase(
            param: param,
            authorization: BaseVC.userData!.accessToken
        )) { response in
            switch response {
            case .success(let result):
                let statusCode = result.statusCode
                switch statusCode {
                case 200..<300:
                    self.success()
                case 400:
                    self.date = ""
                    self.cantborrow()
                case 403:
                    self.accessTokenError()
                case 404:
                    self.date = ""
                    self.err()
                default:
                    self.err()
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
