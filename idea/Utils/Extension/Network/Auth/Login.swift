//
//  Login.swift
//  idea
//
//  Created by 선민재 on 2022/12/19.
//

import UIKit
import Moya

extension LoginViewController {
    
    func success() {
        if emailTextField.text ==  "000000" && pwTextField.text == "000000"{
//            viewModel.pushAdminVC()
        }
        else{
            self.steps.accept(SCStep.homeIsRequired)
        }
    }
    
    func failure() {
        let faliureAlert = UIAlertController(title: nil, message: "아이디 혹은 비밀번호를 다시 확인해주세요", preferredStyle: .alert)
        let faliureAction = UIAlertAction(title: "확인", style: .cancel) {(action) in
        }
        faliureAlert.addAction(faliureAction)
        self.present(faliureAlert, animated: true, completion: nil)
    }
    
    func login() {
        let param = LoginRequest.init(self.emailTextField.text! + "@gsm.hs.kr", self.pwTextField.text!)
        print(param)
        BaseVC.authProvider.request(.login(param: param)) {response in
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
                    self.success()
                default:
                    self.failure()
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
