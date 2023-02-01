//
//  SignUp.swift
//  idea
//
//  Created by 선민재 on 2022/12/19.
//

import UIKit
import Moya

extension SignUpViewController {
    func success() {
        let successAlert = UIAlertController(title: nil, message: "회원가입이 완료되었습니다!", preferredStyle: .alert)
        let successAction = UIAlertAction(title: "확인", style: .cancel) {(action) in
            self.steps.accept(SCStep.signUpIsRequired)
        }
        successAlert.addAction(successAction)
        self.present(successAlert, animated: true, completion: nil)
    }
    func failure() {
        let faliureAlert = UIAlertController(title: nil, message: "정보를 다 입력해주세요", preferredStyle: .alert)
        let faliureAction = UIAlertAction(title: "확인", style: .cancel) {(action) in
        }
        faliureAlert.addAction(faliureAction)
        self.present(faliureAlert, animated: true, completion: nil)
        print("nope")
    }
    func same() {
        let faliureAlert = UIAlertController(title: nil, message: "동일한 아이디 혹은 학번이 존재합니다.", preferredStyle: .alert)
        let faliureAction = UIAlertAction(title: "확인", style: .cancel) {(action) in
        }
        faliureAlert.addAction(faliureAction)
        self.present(faliureAlert, animated: true, completion: nil)
    }
    func signUp() {
        let number = Int(numberTextField.text!) ?? 0
        let param = SignUpRequest.init(self.emailTextField.text! + "@gsm.hs.kr", self.pwTextField.text!, self.nameTextField.text!, number)
        print(param)
        BaseVC.authProvider.request(.signUp(param: param)) {response in
            switch response {
            case .success(let result):
                let statusCode = result.statusCode
                switch statusCode {
                case 200..<300:
                    self.success()
                case 409:
                    self.same()
                default:
                    self.failure()
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
