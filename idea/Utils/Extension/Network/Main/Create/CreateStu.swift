//
//  CreateStu.swift
//  idea
//
//  Created by 선민재 on 2022/12/26.
//

import UIKit
import Moya

extension CreateStuViewController {
    
    func createSuccess() {
        let createSuccessAlert = UIAlertController(title: nil, message: "스터디가 생성되었습니다.", preferredStyle: .alert)
        let createSuccessAction = UIAlertAction(title: "확인", style: .cancel) {(action) in
            self.viewModel.pushMainVC()
        }
        createSuccessAlert.addAction(createSuccessAction)
        self.present(createSuccessAlert, animated: true, completion: nil)
    }
    
    func createFailure() {
        let createFailureAlert = UIAlertController(title: nil, message: "정보를 전부 입력해주세요", preferredStyle: .alert)
        let createFailureAction = UIAlertAction(title: "확인", style: .cancel) {(action) in
        }
        createFailureAlert.addAction(createFailureAction)
        self.present(createFailureAlert, animated: true, completion: nil)
    }
    
    func createError() {
        let createErrorAlert = UIAlertController(title: nil, message: "에러", preferredStyle: .alert)
        let createErrorAction = UIAlertAction(title: "확인", style: .cancel) {(action) in
        }
        createErrorAlert.addAction(createErrorAction)
        self.present(createErrorAlert, animated: true, completion: nil)
    }
    
    func CreateStu() {
        let count:Int = 5
        let studyType:String = "스터디"
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
                let statusCode = result.statusCode
                switch statusCode {
                case 200..<300:
                    self.createSuccess()
                case 400:
                    self.createFailure()
                default:
                    self.createError()
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }

}
