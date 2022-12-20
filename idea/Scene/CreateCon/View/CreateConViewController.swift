//
//  CreateConViewController.swift
//  idea
//
//  Created by 선민재 on 2022/12/20.
//

import UIKit
import Then
import SnapKit

class CreateConViewController: BaseViewController<CreateConViewModel> {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "컨퍼런스"
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    let titleTextField = UITextField().then {
        $0.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        $0.attributedPlaceholder = NSAttributedString(string: "제목", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 113/255, green: 113/255, blue: 113/255, alpha: 1.00)])
        $0.font = UIFont.SCFont(size:20, family:.Regular)
        $0.textColor = UIColor(red: 113/255, green: 113/255, blue: 113/255, alpha: 1.00)
    }
    
    let titleTextFieldLine = UIView().then {
        $0.backgroundColor = .Main
    }
    
    override func addView() {
        [titleTextField,titleTextFieldLine].forEach{
            view.addSubview($0)
        }
    }
    
    override func setLayout() {
        titleTextField.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).offset((bounds.height) / 6.3)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.centerX.equalToSuperview()
        }
        titleTextFieldLine.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(2)
        }
    }

}
