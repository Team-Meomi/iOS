//
//  SignUpViewController.swift
//  idea
//
//  Created by 선민재 on 2022/12/15.
//

import UIKit
import Then
import SnapKit

class SignUpViewController: BaseViewController<SignUpViewModel> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
    }
    
    override func addView() {
        [].forEach {
            view.addSubview($0)
        }
    }
    
    override func setLayout() {
    }

}
