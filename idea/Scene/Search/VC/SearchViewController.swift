//
//  SearchViewController.swift
//  idea
//
//  Created by 선민재 on 2022/12/27.
//

import UIKit
import Then
import SnapKit

class SearchViewController: BaseViewController<SearchViewModel> {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "검색하기"
        self.navigationController?.navigationBar.topItem?.title = ""
        addScrollView()
        setScrollViewLayout()
    }
    
    var postMajor:String = ""
    var guardFeTap:Bool = false
    var guardBeTap:Bool = false
    var guardiOSTap:Bool = false
    var guardAosTap:Bool = false
    var guardEtcTap:Bool = false
    
    let scrollView = UIScrollView().then {
        $0.backgroundColor = .Background
    }
    
    let searchTextField = UITextField().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.Main?.cgColor
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        $0.font = UIFont.SCFont(size: 12,family:.Regular)
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        $0.addRightImage(UIImage(systemName: "magnifyingglass")!, x: -5.5, y: 3.5)
        $0.addLeftPadding(width: 18)
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

    override func addView() {
        [scrollView].forEach {
            view.addSubview($0)
        }
    }
    
    
    func addScrollView() {
        [searchTextField,feBtn,beBtn,iosBtn,aosBtn,etcBtn].forEach {
            scrollView.addSubview($0)
        }
    }
    
    override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    func setScrollViewLayout() {
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.top).offset(15)
            $0.centerX.equalToSuperview()
            $0.trailing.leading.equalToSuperview().inset(33)
            $0.height.equalTo(40)
        }
        feBtn.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(24)
            $0.leading.equalTo(view.snp.leading).offset(33)
            $0.height.equalTo(35)
            $0.width.equalTo(52)
        }
        beBtn.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(24)
            $0.leading.equalTo(feBtn.snp.trailing).offset(12)
            $0.height.equalTo(35)
            $0.width.equalTo(52)
        }
        iosBtn.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(24)
            $0.leading.equalTo(beBtn.snp.trailing).offset(12)
            $0.height.equalTo(35)
            $0.width.equalTo(52)
        }
        aosBtn.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(24)
            $0.leading.equalTo(iosBtn.snp.trailing).offset(12)
            $0.height.equalTo(35)
            $0.width.equalTo(52)
        }
        etcBtn.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(24)
            $0.leading.equalTo(aosBtn.snp.trailing).offset(12)
            $0.height.equalTo(35)
            $0.width.equalTo(52)
        }
    }
}
