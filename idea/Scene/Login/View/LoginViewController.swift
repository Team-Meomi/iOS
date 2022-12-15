//
//  LoginViewController.swift
//  idea
//
//  Created by 선민재 on 2022/12/15.
//

import UIKit
import Then
import SnapKit

class LoginViewController: BaseViewController<LoginViewModel> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    let loginText = UILabel().then {
        $0.text = "Login"
        $0.font = UIFont.SCFont(size: 24, family: .Regular)
        $0.tintColor = .black
    }
    
    override func addView() {
        [loginText].forEach {
            view.addSubview($0)
        }
    }
    
    override func setLayout() {
        loginText.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).offset(bounds.height / 5.52)
            $0.centerX.equalToSuperview()
        }
    }

}
