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

    override func addView() {
        [].forEach {
            view.addSubview($0)
        }
    }
    
    override func setLayout() {
        
    }
}
