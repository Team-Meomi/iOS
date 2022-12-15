//
//  ViewController.swift
//  idea
//
//  Created by 선민재 on 2022/12/07.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

class IntroViewController: BaseViewController<IntroViewModel> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    let studyText = UILabel().then {
        $0.text = "Study"
        $0.font = UIFont.SCFont(size: 26,family: .Regular)
        $0.textColor = .Main
    }
    
    let andText = UILabel().then {
        $0.text = "&"
        $0.font = UIFont.SCFont(size: 20,family: .Regular)
        $0.textColor = .black
    }
    
    let conferenceText = UILabel().then {
        $0.text = "Conference"
        $0.font = UIFont.SCFont(size: 26,family: .Regular)
        $0.textColor = .Main
    }
    
    lazy var loginButton = UIButton().then {
        let text = NSAttributedString(string: "Login")
        $0.setAttributedTitle(text, for: .normal)
        $0.titleLabel?.font = UIFont.SCFont(size: 12, family: .Bold)
        $0.setTitleColor(UIColor.Main, for: .normal)
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor.Main?.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 5
    }
    
    lazy var signUpButton = UIButton().then {
        let text = NSAttributedString(string: "SignUp")
        $0.setAttributedTitle(text, for: .normal)
        $0.titleLabel?.font = UIFont.SCFont(size: 12, family: .Bold)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.backgroundColor = .Main
        $0.layer.cornerRadius = 5
    }
    
    override func addView() {
        [studyText,andText,conferenceText,loginButton,signUpButton].forEach {
            view.addSubview($0)
        }
    }
    
    override func setLayout() {
        studyText.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).offset((bounds.height)/4.64)
            $0.centerX.equalToSuperview()
        }
        
        andText.snp.makeConstraints {
            $0.top.equalTo(studyText.snp.bottom).offset(0)
            $0.centerX.equalToSuperview()
        }
        
        conferenceText.snp.makeConstraints {
            $0.top.equalTo(andText.snp.bottom).offset(0)
            $0.centerX.equalToSuperview()
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(conferenceText.snp.bottom).offset((bounds.height) / 2.62)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
            $0.leading.trailing.equalToSuperview().inset(44)
        }
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(18)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
            $0.leading.trailing.equalToSuperview().inset(44)
        }
    }

}
