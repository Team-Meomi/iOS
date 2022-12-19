//
//  LoginViewController.swift
//  idea
//
//  Created by 선민재 on 2022/12/15.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa
import Moya

class LoginViewController: BaseViewController<LoginViewModel> {
    var essentialFieldList = [UITextField]()
    var check: Bool?
    let authProvider = MoyaProvider<LoginServices>(plugins: [NetworkLoggerPlugin()])
    var userData: LoginModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,selector: #selector(textDidChange(_:)),name: UITextField.textDidChangeNotification,object: emailTextField)
        essentialFieldList = [emailTextField,pwTextField]
    }
    
    let loginText = UILabel().then {
        $0.text = "Login"
        $0.font = UIFont.SCFont(size: 24, family: .Regular)
        $0.tintColor = .black
    }
    
    let contantText = UILabel().then {
        $0.text = "컨퍼런스와 스터디의 재미를\n느껴보세요!"
        $0.numberOfLines = 2
        $0.textAlignment = .center
        $0.font = UIFont.SCFont(size:14, family:.Regular)
        $0.textColor = UIColor(red: 103/255, green: 103/255, blue: 103/255, alpha: 1)
    }
    
    lazy var emailTextField = UITextField().then {
        $0.backgroundColor = .white
        $0.attributedPlaceholder = NSAttributedString(string: "ID", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 163/255, green: 163/255, blue: 163/255, alpha: 1.00)])
        $0.font = UIFont.SCFont(size:13, family:.Regular)
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        $0.layer.applySketchShadow(color: .black, alpha: 0.08, x: 0, y: 0, blur: 13, spread: 0)
        $0.layer.cornerRadius = 14
        $0.addLeftPadding()
    }
    
    let emailText = UILabel().then {
        $0.text = "@gsm.hs.kr"
        $0.font = UIFont.SCFont(size:13, family:.Regular)
        $0.textColor = UIColor(red: 163/255, green: 163/255, blue: 163/255, alpha: 1.00)
    }
    
    lazy var pwTextField = UITextField().then {
        $0.backgroundColor = .white
        $0.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 163/255, green: 163/255, blue: 163/255, alpha: 1.00)])
        $0.font = UIFont.SCFont(size:13, family:.Regular)
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        $0.layer.applySketchShadow(color: .black, alpha: 0.08, x: 0, y: 0, blur: 13, spread: 0)
        $0.layer.cornerRadius = 14
        $0.addLeftPadding()
    }
    
    lazy var loginButton = UIButton().then {
        let text = NSAttributedString(string: "login")
        $0.setAttributedTitle(text, for: .normal)
        $0.titleLabel?.font = UIFont.SCFont(size: 14, family: .Bold)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.backgroundColor = .Main
        $0.layer.cornerRadius = 5
        $0.addTarget(self, action: #selector(loginBtnDidTap), for: .touchUpInside)
    }
    
    let goSignUp = UILabel().then {
        $0.text = "계정이 없으신가요?"
        $0.font = UIFont.SCFont(size:12 ,family:.Medium)
        $0.textColor = UIColor(red: 154/255, green: 154/255, blue: 154/255, alpha: 1.0)
    }
    
    lazy var goSignUpButton = UIButton().then {
        let text = NSAttributedString(string: "회원가입")
        $0.setAttributedTitle(text, for: .normal)
        $0.titleLabel?.font = UIFont.SCFont(size: 12,family:.Bold)
        $0.setTitleColor(UIColor(red: 119/255, green: 203/255, blue: 158/255, alpha: 1.00), for: .normal)
        $0.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        $0.addTarget(self, action: #selector(goSignUpBtnDidTap), for: .touchUpInside)
    }
    
    func LoginAlert(_ field: UITextField) {
        DispatchQueue.main.async {
            switch field {
            case self.emailTextField:
                self.emailTextField.layer.borderWidth = 1
                self.emailTextField.layer.borderColor = UIColor(red: 236/255, green: 149/255, blue: 149/255, alpha: 1).cgColor
                break
            case self.pwTextField:
                self.pwTextField.layer.borderWidth = 1
                self.pwTextField.layer.borderColor = UIColor(red: 236/255, green: 149/255, blue: 149/255, alpha: 1).cgColor
                break
            default:
                print("error")
            }
        }
    }
    func isFilled(_ textField: UITextField) -> Bool {
        guard let text = textField.text, !text.isEmpty else {
            return false
        }
        return true
    }
    
    @objc func loginBtnDidTap() {
        for field in essentialFieldList {
            if !isFilled(field) {
                LoginAlert(field)
            }
            
        }
        login()
    }
    
    @objc func goSignUpBtnDidTap(){
        viewModel.pushSignUpVC()
    }
    
    @objc private func textDidChange(_ notification: Notification) {
        if let textField = notification.object as? UITextField {
            if let text = textField.text {
                    
                if text.count > maxLength {
                    textField.resignFirstResponder()
                }
                if text.count >= maxLength {
                    let index = text.index(text.startIndex, offsetBy: maxLength)
                    let newString = text[text.startIndex..<index]
                    textField.text = String(newString)
                }
            }
        }
    }
    
    override func addView() {
        [loginText,contantText,emailTextField,emailText,pwTextField,loginButton,goSignUp,goSignUpButton].forEach {
            view.addSubview($0)
        }
    }
    
    override func setLayout() {
        loginText.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).offset(bounds.height / 5.52)
            $0.centerX.equalToSuperview()
        }
        contantText.snp.makeConstraints {
            $0.top.equalTo(loginText.snp.bottom).offset((bounds.height) / 15.16)
            $0.centerX.equalToSuperview()
        }
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(contantText.snp.bottom).offset((bounds.height) / 10.68)
            $0.leading.trailing.equalToSuperview().inset((bounds.width) / 8.5)
            $0.height.equalTo(51)
        }
        emailText.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.top).offset(16)
            $0.trailing.equalTo(emailTextField.snp.trailing).inset(19)
        }
        pwTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(28)
            $0.leading.trailing.equalToSuperview().inset((bounds.width) / 8.5)
            $0.height.equalTo(51)
        }
        loginButton.snp.makeConstraints {
            $0.top.equalTo(pwTextField.snp.bottom).offset((bounds.height) / 5.88)
            $0.height.equalTo(50)
            $0.leading.trailing.equalToSuperview().inset((bounds.width) / 8.5)
        }
        goSignUp.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset((bounds.height) / 16.91)
            $0.leading.equalTo(view.snp.leading).offset((bounds.width) / 3.34)
        }
        goSignUpButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset((bounds.height) / 16.91)
            $0.leading.equalTo(goSignUp.snp.trailing).offset(2)
            $0.height.equalTo(16)
        }
    }

}
