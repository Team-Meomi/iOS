//
//  ProfileViewController.swift
//  idea
//
//  Created by 선민재 on 2022/12/28.
//

import UIKit
import Then
import MSGLayout
import Moya

class ProfileViewController: BaseViewController<ProfileViewModel> {
    
    override func viewDidLoad() {
        getMyData()
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.logoutImage()
    }
    
    let userImage = UIImageView().then {
        $0.image = UIImage(named: "profileImage.svg")
    }
    
    lazy var userNameText = UILabel().then {
        $0.font = UIFont.SCFont(size: 18,family: .Medium)
        $0.textColor = .black
    }
    
    lazy var openedBtn = UIButton().then {
        let text = NSAttributedString(string: "개설한")
        $0.setAttributedTitle(text, for: .normal)
        $0.titleLabel?.font = UIFont.SCFont(size: 14, family: .Medium)
        $0.setTitleColor(UIColor.Main, for: .normal)
        $0.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        $0.layer.cornerRadius = 5
        $0.addTarget(self, action: #selector(openedBtnDidTap), for: .touchUpInside)
    }
    
    lazy var appliedBtn = UIButton().then {
        let text = NSAttributedString(string: "신청한")
        $0.setAttributedTitle(text, for: .normal)
        $0.titleLabel?.font = UIFont.SCFont(size: 14, family: .Medium)
        $0.setTitleColor(UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1), for: .normal)
        $0.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        $0.layer.cornerRadius = 5
        $0.addTarget(self, action: #selector(appliedBtnDidTap), for: .touchUpInside)
    }
    
    let divisionLine = UIView().then {
        $0.backgroundColor = .Main
        $0.layer.cornerRadius = 4
    }
    
    @objc func openedBtnDidTap() {
        openedBtn.setTitleColor(UIColor.Main, for: .normal)
        appliedBtn.setTitleColor(UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1), for: .normal)
    }

    @objc func appliedBtnDidTap() {
        appliedBtn.setTitleColor(UIColor.Main, for: .normal)
        openedBtn.setTitleColor(UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1), for: .normal)
    }
    
    override func addView() {
        [userImage,userNameText,openedBtn,appliedBtn,divisionLine].forEach {
            view.addSubview($0)
        }
    }
    
    override func setLayout() {
        MSGLayout.buildLayout {
            userImage.layout
                .top(.to(view).top, .equal((bounds.height) / 9.55))
                .centerX(.toSuperview())
            userNameText.layout
                .top(.to(userImage).bottom, .equal(4))
                .centerX(.toSuperview())
            openedBtn.layout
                .top(.to(userNameText).bottom, .equal((bounds.height) / 15.16))
                .leading(.to(view).leading, .equal((bounds.width) / 3.75))
            appliedBtn.layout
                .top(.to(userNameText).bottom, .equal((bounds.height) / 15.16))
                .trailing(.to(view).trailing, .equal(-(bounds.width) / 3.75))
            divisionLine.layout
                .top(.to(userNameText).bottom, .equal((bounds.height) / 17.276))
                .centerX(.toSuperview())
                .width(3)
                .height(30)
        }
    }
}
