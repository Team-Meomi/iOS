//
//  CreateConViewController.swift
//  idea
//
//  Created by 선민재 on 2022/12/20.
//

import UIKit
import Then
import SnapKit

class CreateConViewController: BaseViewController<CreateConViewModel>,UITextViewDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "컨퍼런스"
        self.navigationController?.navigationBar.topItem?.title = ""
        placeholderSetting()
        textViewDidBeginEditing(explainTextView)
        textViewDidEndEditing(explainTextView)
    }
    
    private let titleTextField = UITextField().then {
        $0.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        $0.attributedPlaceholder = NSAttributedString(string: "제목", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 113/255, green: 113/255, blue: 113/255, alpha: 1.00)])
        $0.font = UIFont.SCFont(size:20, family:.Regular)
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.00)
    }
    
    private let titleTextFieldLine = UIView().then {
        $0.backgroundColor = .Main
    }
    
    private let explainTextView = UITextView().then {
        $0.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
        $0.font = UIFont.SCFont(size:14, family:.Regular)
        $0.textColor = .black
        $0.layer.cornerRadius = 8
        $0.textAlignment = .left
    }
    
    private func placeholderSetting() {
        explainTextView.delegate = self
        explainTextView.text = "설명"
        explainTextView.textColor = UIColor.lightGray
    }
        
    private func textViewDidBeginEditing(_ textView: UITextView) {
        if explainTextView.textColor == UIColor.lightGray {
            explainTextView.text = nil
            explainTextView.textColor = UIColor.black
        }
        
    }
    private func textViewDidEndEditing(_ textView: UITextView) {
        if explainTextView.text.isEmpty {
            explainTextView.text = "설명"
            explainTextView.textColor = UIColor.lightGray
        }
    }

    lazy var selectDateBtn = UIButton().then {
        let text = NSAttributedString(string: "  날짜를 선택해주세요")
        $0.setAttributedTitle(text, for: .normal)
        $0.titleLabel?.font = UIFont.SCFont(size: 14, family: .Medium)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.layer.borderColor = UIColor.Main?.cgColor
        $0.layer.borderWidth = 1
        $0.setImage(UIImage(systemName: "calendar"), for: .normal)
        $0.tintColor = .Main
//        $0.addTarget(self, action: #selector(signUpBtnDidTap), for: .touchUpInside)
    }
    
    private let countTextField = UITextField().then {
        $0.backgroundColor = .white
        $0.attributedPlaceholder = NSAttributedString(string: "최대 인원 수를 입력해주세요.", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 163/255, green: 163/255, blue: 163/255, alpha: 1.00)])
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont.SCFont(size:14, family:.Medium)
        $0.addLeftImage(UIImage(systemName: "person.2.fill")!, x: 13, y:6)
        $0.layer.borderColor = UIColor.Main?.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 8
        $0.keyboardType = .numberPad
    }
    
    lazy var feBtn = UIButton().then {
        let text = NSAttributedString(string: "FE")
        $0.setAttributedTitle(text, for: .normal)
        $0.titleLabel?.font = UIFont.SCFont(size: 12, family: .Bold)
        $0.setTitleColor(UIColor(red: 82/255, green: 82/255, blue: 87/255, alpha: 1), for: .normal)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.layer.borderColor = UIColor.Main?.cgColor
        $0.layer.borderWidth = 1
    }
    
    lazy var beBtn = UIButton().then {
        let text = NSAttributedString(string: "BE")
        $0.setAttributedTitle(text, for: .normal)
        $0.titleLabel?.font = UIFont.SCFont(size: 12, family: .Bold)
        $0.setTitleColor(UIColor(red: 82/255, green: 82/255, blue: 87/255, alpha: 1), for: .normal)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.layer.borderColor = UIColor.Main?.cgColor
        $0.layer.borderWidth = 1
    }
    
    lazy var iosBtn = UIButton().then {
        let text = NSAttributedString(string: "iOS")
        $0.setAttributedTitle(text, for: .normal)
        $0.titleLabel?.font = UIFont.SCFont(size: 12, family: .Bold)
        $0.setTitleColor(UIColor(red: 82/255, green: 82/255, blue: 87/255, alpha: 1), for: .normal)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.layer.borderColor = UIColor.Main?.cgColor
        $0.layer.borderWidth = 1
    }
    
    lazy var aosBtn = UIButton().then {
        let text = NSAttributedString(string: "AOS")
        $0.setAttributedTitle(text, for: .normal)
        $0.titleLabel?.font = UIFont.SCFont(size: 12, family: .Bold)
        $0.setTitleColor(UIColor(red: 82/255, green: 82/255, blue: 87/255, alpha: 1), for: .normal)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.layer.borderColor = UIColor.Main?.cgColor
        $0.layer.borderWidth = 1
    }
    
    lazy var etcBtn = UIButton().then {
        let text = NSAttributedString(string: "기타")
        $0.setAttributedTitle(text, for: .normal)
        $0.titleLabel?.font = UIFont.SCFont(size: 12, family: .Bold)
        $0.setTitleColor(UIColor(red: 82/255, green: 82/255, blue: 87/255, alpha: 1), for: .normal)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.layer.borderColor = UIColor.Main?.cgColor
        $0.layer.borderWidth = 1
    }
    
    lazy var makeBtn = UIButton().then {
        let text = NSAttributedString(string: "만들기")
        $0.setAttributedTitle(text, for: .normal)
        $0.titleLabel?.font = UIFont.SCFont(size: 14, family: .Bold)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.backgroundColor = .Main
        $0.layer.cornerRadius = 8
    }
    
    override func addView() {
        [titleTextField,titleTextFieldLine,explainTextView,selectDateBtn,countTextField,feBtn,beBtn,iosBtn,aosBtn,etcBtn,makeBtn].forEach{
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
        explainTextView.snp.makeConstraints {
            $0.top.equalTo(titleTextFieldLine.snp.bottom).offset(22)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo((bounds.height) / 7.73)
        }
        selectDateBtn.snp.makeConstraints {
            $0.top.equalTo(explainTextView.snp.bottom).offset(31)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(40)
        }
        countTextField.snp.makeConstraints {
            $0.top.equalTo(selectDateBtn.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(40)
        }
        feBtn.snp.makeConstraints {
            $0.top.equalTo(countTextField.snp.bottom).offset(24)
            $0.leading.equalTo(view.snp.leading).offset(26)
            $0.height.equalTo(35)
            $0.width.equalTo(55)
        }
        beBtn.snp.makeConstraints {
            $0.top.equalTo(countTextField.snp.bottom).offset(24)
            $0.leading.equalTo(feBtn.snp.trailing).offset(12)
            $0.height.equalTo(35)
            $0.width.equalTo(55)
        }
        iosBtn.snp.makeConstraints {
            $0.top.equalTo(countTextField.snp.bottom).offset(24)
            $0.leading.equalTo(beBtn.snp.trailing).offset(12)
            $0.height.equalTo(35)
            $0.width.equalTo(55)
        }
        aosBtn.snp.makeConstraints {
            $0.top.equalTo(countTextField.snp.bottom).offset(24)
            $0.leading.equalTo(iosBtn.snp.trailing).offset(12)
            $0.height.equalTo(35)
            $0.width.equalTo(55)
        }
        etcBtn.snp.makeConstraints {
            $0.top.equalTo(countTextField.snp.bottom).offset(24)
            $0.leading.equalTo(aosBtn.snp.trailing).offset(12)
            $0.height.equalTo(35)
            $0.width.equalTo(55)
        }
        makeBtn.snp.makeConstraints {
            $0.bottom.equalTo(view.snp.bottom).inset((bounds.height) / 11.9)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(45)
        }
    }

}
