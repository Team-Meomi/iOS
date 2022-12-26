//
//  Create.swift
//  idea
//
//  Created by 선민재 on 2022/12/26.
//

import UIKit
import Moya

extension CreateConViewController {
    
    func createSuccess() {
        let createSuccessAlert = UIAlertController(title: nil, message: "컨퍼런스가 생성되었습니다.", preferredStyle: .alert)
        let createSuccessAction = UIAlertAction(title: "확인", style: .cancel) {(action) in
            self.viewModel.pushMainVC()
        }
        createSuccessAlert.addAction(createSuccessAction)
        self.present(createSuccessAlert, animated: true, completion: nil)
    }
    
    func createFailure() {
        let createFailureAlert = UIAlertController(title: nil, message: "에러", preferredStyle: .alert)
        let createFailureAction = UIAlertAction(title: "확인", style: .cancel) {(action) in
        }
        createFailureAlert.addAction(createFailureAction)
        self.present(createFailureAlert, animated: true, completion: nil)
    }
    
    func CreateCon() {
        let count = Int(countTextField.text!) ?? 0
        let studyType:String = "컨퍼런스"
        let param = CreateRequest.init(BaseVC.userData!.accessToken,
                                       self.titleTextField.text!,
                                       self.explainTextView.text!,
                                       self.postMajor,
                                       self.date,
                                       count,
                                       studyType)
        print(param)
        BaseVC.mainProvider.request(.create(
            param: param,
            authorization: BaseVC.userData!.accessToken
        )) { response in
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
                    self.createSuccess()
                default:
                    self.createFailure()
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }

}