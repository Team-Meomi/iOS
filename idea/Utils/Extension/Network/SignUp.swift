//
//  SignUp.swift
//  idea
//
//  Created by 선민재 on 2022/12/19.
//

import UIKit
import Moya

extension SignUpViewController {
    func signUp() {
        let param = SignUpRequest.init(self.emailTextField.text!, self.pwTextField.text!, self.nameTextField.text!, self.numberTextField.hash)
        print(param)
        authProvider.request(.signUp(param: param)) {response in
            switch response {
            case .success(let result):
                do {
                    self.userData = try result.map(SignupModel.self)
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
