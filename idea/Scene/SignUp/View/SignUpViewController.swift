//
//  SignUpViewController.swift
//  idea
//
//  Created by 선민재 on 2022/12/15.
//

import UIKit
import Then
import SnapKit
import RxCocoa
import RxSwift
import Moya

class SignUpViewController: BaseViewController<SignUpViewModel> {
    
    let authProvider = MoyaProvider<LoginServices>(plugins: [NetworkLoggerPlugin()])
    var userData: SignupModel?
    var essentialFieldList = [UITextField]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,selector: #selector(textDidChange(_:)),name: UITextField.textDidChangeNotification,object: emailTextField)
        essentialFieldList = [emailTextField,pwTextField,nameTextField,numberTextField]
    }
    
    private let signUpText = UILabel().then {
        $0.text = "Sign up"
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
        $0.addLeftPadding(width: 18)
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
        $0.addLeftPadding(width: 18)
    }
    
    lazy var nameTextField = UITextField().then {
        $0.backgroundColor = .white
        $0.attributedPlaceholder = NSAttributedString(string: "이름", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 163/255, green: 163/255, blue: 163/255, alpha: 1.00)])
        $0.font = UIFont.SCFont(size:13, family:.Regular)
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        $0.layer.applySketchShadow(color: .black, alpha: 0.08, x: 0, y: 0, blur: 13, spread: 0)
        $0.layer.cornerRadius = 14
        $0.addLeftPadding(width: 18)
    }
    
    lazy var numberTextField = UITextField().then {
        $0.backgroundColor = .white
        $0.attributedPlaceholder = NSAttributedString(string: "학번", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 163/255, green: 163/255, blue: 163/255, alpha: 1.00)])
        $0.font = UIFont.SCFont(size:13, family:.Regular)
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        $0.layer.applySketchShadow(color: .black, alpha: 0.08, x: 0, y: 0, blur: 13, spread: 0)
        $0.layer.cornerRadius = 14
        $0.addLeftPadding(width: 18)
    }
    
    lazy var signUpButton = UIButton().then {
        let text = NSAttributedString(string: "sign up")
        $0.setAttributedTitle(text, for: .normal)
        $0.titleLabel?.font = UIFont.SCFont(size: 14, family: .Bold)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.backgroundColor = .Main
        $0.layer.cornerRadius = 5
        $0.addTarget(self, action: #selector(signUpBtnDidTap), for: .touchUpInside)
    }
    
    let goLogin = UILabel().then {
        $0.text = "이미 계정이 있으신가요?"
        $0.font = UIFont.SCFont(size:12 ,family:.Medium)
        $0.textColor = UIColor(red: 154/255, green: 154/255, blue: 154/255, alpha: 1.0)
    }
    
    lazy var goLoginButton = UIButton().then {
        let text = NSAttributedString(string: "로그인")
        $0.setAttributedTitle(text, for: .normal)
        $0.titleLabel?.font = UIFont.SCFont(size: 12,family:.Bold)
        $0.setTitleColor(UIColor(red: 119/255, green: 203/255, blue: 158/255, alpha: 1.00), for: .normal)
        $0.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        $0.addTarget(self, action: #selector(goLoginBtnDidTap), for: .touchUpInside)
    }
    
    func signUpAlert(_ field: UITextField) {
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
            case self.nameTextField:
                self.nameTextField.layer.borderWidth = 1
                self.nameTextField.layer.borderColor = UIColor(red: 236/255, green: 149/255, blue: 149/255, alpha: 1).cgColor
                break
            case self.numberTextField:
                self.numberTextField.layer.borderWidth = 1
                self.numberTextField.layer.borderColor = UIColor(red: 236/255, green: 149/255, blue: 149/255, alpha: 1).cgColor
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
    
    @objc func signUpBtnDidTap() {
        for field in essentialFieldList {
            if !isFilled(field) {
                signUpAlert(field)
            }
        }
        signUp()
    }
    
    @objc func goLoginBtnDidTap() {
        viewModel.pushLoginVC()
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
        [signUpText,contantText,emailTextField,emailText,pwTextField,nameTextField,numberTextField,signUpButton,goLogin,goLoginButton].forEach {
            view.addSubview($0)
        }
    }
    
    override func setLayout() {
        signUpText.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).offset(bounds.height / 5.52)
            $0.centerX.equalToSuperview()
        }
        contantText.snp.makeConstraints {
            $0.top.equalTo(signUpText.snp.bottom).offset((bounds.height) / 15.16)
            $0.centerX.equalToSuperview()
        }
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(contantText.snp.bottom).offset((bounds.height) / 20.3)
            $0.leading.trailing.equalToSuperview().inset((bounds.width) / 8.5)
            $0.height.equalTo(51)
        }
        emailText.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.top).offset(16)
            $0.trailing.equalTo(emailTextField.snp.trailing).inset(19)
        }
        pwTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset((bounds.width) / 8.5)
            $0.height.equalTo(51)
        }
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(pwTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset((bounds.width) / 8.5)
            $0.height.equalTo(51)
        }
        numberTextField.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset((bounds.width) / 8.5)
            $0.height.equalTo(51)
        }
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(numberTextField.snp.bottom).offset((bounds.height) / 20.3)
            $0.height.equalTo(50)
            $0.leading.trailing.equalToSuperview().inset((bounds.width) / 8.5)
        }
        goLogin.snp.makeConstraints {
            $0.top.equalTo(signUpButton.snp.bottom).offset((bounds.height) / 16.91)
            $0.leading.equalTo(view.snp.leading).offset((bounds.width) / 3.34)
        }
        goLoginButton.snp.makeConstraints {
            $0.top.equalTo(signUpButton.snp.bottom).offset((bounds.height) / 16.91)
            $0.leading.equalTo(goLogin.snp.trailing).offset(2)
            $0.height.equalTo(16)
        }
    }

}
