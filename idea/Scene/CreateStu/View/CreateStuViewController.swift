//
//  CreateStuViewController.swift
//  idea
//
//  Created by 선민재 on 2022/12/20.
//

//
//  CreateConViewController.swift
//  idea
//
//  Created by 선민재 on 2022/12/20.
//

import UIKit
import Then
import SnapKit
import Moya

class CreateStuViewController: BaseViewController<CreateStuViewModel>,UITextViewDelegate{
    lazy var date = dateFormatter.string(from: datePicker.date)
    let dateFormatter = DateFormatter()
    var postMajor:String = ""
    var guardFeTap:Bool = false
    var guardBeTap:Bool = false
    var guardiOSTap:Bool = false
    var guardAosTap:Bool = false
    var guardEtcTap:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "스터디"
        self.navigationController?.navigationBar.topItem?.title = ""
        placeholderSetting()
        textViewDidBeginEditing(explainTextView)
        textViewDidEndEditing(explainTextView)
    }
    
    let titleTextField = UITextField().then {
        $0.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        $0.attributedPlaceholder = NSAttributedString(string: "제목", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 113/255, green: 113/255, blue: 113/255, alpha: 1.00)])
        $0.font = UIFont.SCFont(size:20, family:.Regular)
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.00)
    }
    
    let titleTextFieldLine = UIView().then {
        $0.backgroundColor = .Main
    }
    
    let explainTextView = UITextView().then {
        $0.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
        $0.font = UIFont.SCFont(size:14, family:.Regular)
        $0.textColor = .black
        $0.layer.cornerRadius = 8
        $0.textAlignment = .left
    }
    
    func placeholderSetting() {
        explainTextView.delegate = self
        explainTextView.text = "설명"
        explainTextView.textColor = UIColor.lightGray
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if explainTextView.textColor == UIColor.lightGray {
            explainTextView.text = nil
            explainTextView.textColor = UIColor.black
        }
        
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if explainTextView.text.isEmpty {
            explainTextView.text = "설명"
            explainTextView.textColor = UIColor.lightGray
        }
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
        $0.addTarget(self, action: #selector(feBtnDidTap), for: .touchUpInside)
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
        $0.addTarget(self, action: #selector(beBtnDidTap), for: .touchUpInside)
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
        $0.addTarget(self, action: #selector(iOSBtnDidTap), for: .touchUpInside)
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
        $0.addTarget(self, action: #selector(aosBtnDidTap), for: .touchUpInside)
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
        $0.addTarget(self, action: #selector(etcBtnDidTap), for: .touchUpInside)
    }
    
    lazy var makeBtn = UIButton().then {
        let text = NSAttributedString(string: "만들기")
        $0.setAttributedTitle(text, for: .normal)
        $0.titleLabel?.font = UIFont.SCFont(size: 14, family: .Bold)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.backgroundColor = .Main
        $0.layer.cornerRadius = 8
        $0.addTarget(self, action: #selector(makeBtnDidTap), for: .touchUpInside)
    }
    
    let selectText = UILabel().then {
        $0.text = "날짜를 선택해 주세요"
        $0.textColor = UIColor(red: 163/255, green: 163/255, blue: 163/255, alpha: 1.00)
        $0.font = UIFont.SCFont(size:14,family:.Medium)
    }
    
    let calenderIcon = UIImageView().then {
        $0.image = UIImage(systemName: "calendar")
        $0.tintColor = .Main
    }
    
    let selectView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.layer.borderColor = UIColor.Main?.cgColor
        $0.layer.borderWidth = 1
    }
    
    let datePicker = UIDatePicker().then {
        $0.preferredDatePickerStyle = .compact
        $0.datePickerMode = .date
        $0.locale = Locale(identifier: "ko-KR")
        $0.timeZone = .autoupdatingCurrent
        $0.translatesAutoresizingMaskIntoConstraints = true
        $0.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
    }
    
    @objc func makeBtnDidTap() {
        createStu()
    }
    
    
    @objc func feBtnDidTap() {
        guard guardFeTap != true else{
            feBtn.setTitleColor(UIColor(red: 82/255, green: 82/255, blue: 87/255, alpha: 1), for: .normal)
            feBtn.layer.borderColor = UIColor.Main?.cgColor
            feBtn.layer.borderWidth = 1
            feBtn.backgroundColor = .white
            self.postMajor = ""
            self.guardFeTap = false
            return
        }
        guard guardBeTap != true && guardiOSTap != true && guardAosTap != true && guardEtcTap != true else{return}
        feBtn.layer.borderColor = UIColor.FE?.cgColor
        feBtn.backgroundColor = .FE
        feBtn.setTitleColor(UIColor.white,for: .normal)
        self.postMajor = "FE"
        self.guardFeTap = true
    }
    
    @objc func beBtnDidTap() {
        guard guardBeTap != true else{
            beBtn.setTitleColor(UIColor(red: 82/255, green: 82/255, blue: 87/255, alpha: 1), for: .normal)
            beBtn.layer.borderColor = UIColor.Main?.cgColor
            beBtn.layer.borderWidth = 1
            beBtn.backgroundColor = .white
            self.postMajor = ""
            self.guardBeTap = false
            return
        }
        guard guardFeTap != true && guardiOSTap != true && guardAosTap != true && guardEtcTap != true else{return}
        beBtn.layer.borderColor = UIColor.BE?.cgColor
        beBtn.backgroundColor = .BE
        beBtn.setTitleColor(UIColor.white,for: .normal)
        self.postMajor = "BE"
        self.guardBeTap = true
    }
    
    @objc func iOSBtnDidTap() {
        guard guardiOSTap != true else{
            iosBtn.setTitleColor(UIColor(red: 82/255, green: 82/255, blue: 87/255, alpha: 1), for: .normal)
            iosBtn.layer.borderColor = UIColor.Main?.cgColor
            iosBtn.layer.borderWidth = 1
            iosBtn.backgroundColor = .white
            self.postMajor = ""
            self.guardiOSTap = false
            return
        }
        guard guardFeTap != true && guardBeTap != true && guardAosTap != true && guardEtcTap != true else{return}
        iosBtn.layer.borderColor = UIColor.iOS?.cgColor
        iosBtn.backgroundColor = .iOS
        iosBtn.setTitleColor(UIColor.white,for: .normal)
        self.postMajor = "iOS"
        self.guardiOSTap = true
    }
    
    @objc func aosBtnDidTap() {
        guard guardAosTap != true else{
            aosBtn.setTitleColor(UIColor(red: 82/255, green: 82/255, blue: 87/255, alpha: 1), for: .normal)
            aosBtn.layer.borderColor = UIColor.Main?.cgColor
            aosBtn.layer.borderWidth = 1
            aosBtn.backgroundColor = .white
            self.postMajor = ""
            self.guardAosTap = false
            return
        }
        guard guardFeTap != true && guardBeTap != true && guardiOSTap != true && guardEtcTap != true else{return}
        aosBtn.layer.borderColor = UIColor.AOS?.cgColor
        aosBtn.backgroundColor = .AOS
        aosBtn.setTitleColor(UIColor.white,for: .normal)
        self.postMajor = "AOS"
        self.guardAosTap = true
    }
    
    @objc func etcBtnDidTap() {
        guard guardEtcTap != true else{
            etcBtn.setTitleColor(UIColor(red: 82/255, green: 82/255, blue: 87/255, alpha: 1), for: .normal)
            etcBtn.layer.borderColor = UIColor.Main?.cgColor
            etcBtn.layer.borderWidth = 1
            etcBtn.backgroundColor = .white
            self.postMajor = ""
            self.guardEtcTap = false
            return
        }
        guard guardFeTap != true && guardBeTap != true && guardiOSTap != true && guardAosTap != true else{return}
        etcBtn.layer.borderColor = UIColor.Etc?.cgColor
        etcBtn.backgroundColor = .Etc
        etcBtn.setTitleColor(UIColor.white,for: .normal)
        self.postMajor = "기타"
        self.guardEtcTap = true
    }
    
    @objc func handleDatePicker() {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        selectText.text = dateFormatter.string(from: datePicker.date)
        print(datePicker.date)
        checkHomebase()
    }
    
    
    override func addView() {
        [titleTextField,titleTextFieldLine,explainTextView,selectView,selectText,calenderIcon,datePicker,feBtn,beBtn,iosBtn,aosBtn,etcBtn,makeBtn].forEach{
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
        selectView.snp.makeConstraints {
            $0.top.equalTo(explainTextView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(40)
        }
        selectText.snp.makeConstraints {
            $0.centerY.equalTo(selectView.snp.centerY).offset(0)
            $0.leading.equalTo(selectView.snp.leading).offset(45)
        }
        calenderIcon.snp.makeConstraints {
            $0.centerY.equalTo(selectView.snp.centerY).offset(0)
            $0.leading.equalTo(selectView.snp.leading).offset(14)
            $0.height.equalTo(24)
            $0.width.equalTo(24)
        }
        datePicker.snp.makeConstraints {
            $0.centerY.equalTo(selectView.snp.centerY).offset(0)
            $0.trailing.equalTo(selectView.snp.trailing).inset(2)
        }
        feBtn.snp.makeConstraints {
            $0.top.equalTo(selectView.snp.bottom).offset(24)
            $0.leading.equalTo(view.snp.leading).offset(26)
            $0.height.equalTo(35)
            $0.width.equalTo(55)
        }
        beBtn.snp.makeConstraints {
            $0.top.equalTo(selectView.snp.bottom).offset(24)
            $0.leading.equalTo(feBtn.snp.trailing).offset(12)
            $0.height.equalTo(35)
            $0.width.equalTo(55)
        }
        iosBtn.snp.makeConstraints {
            $0.top.equalTo(selectView.snp.bottom).offset(24)
            $0.leading.equalTo(beBtn.snp.trailing).offset(12)
            $0.height.equalTo(35)
            $0.width.equalTo(55)
        }
        aosBtn.snp.makeConstraints {
            $0.top.equalTo(selectView.snp.bottom).offset(24)
            $0.leading.equalTo(iosBtn.snp.trailing).offset(12)
            $0.height.equalTo(35)
            $0.width.equalTo(55)
        }
        etcBtn.snp.makeConstraints {
            $0.top.equalTo(selectView.snp.bottom).offset(24)
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
