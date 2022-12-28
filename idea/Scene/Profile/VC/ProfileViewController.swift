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

    override func addView() {
        [userImage,userNameText].forEach {
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
        }
    }
}
