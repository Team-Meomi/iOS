//
//  ProfileViewController.swift
//  idea
//
//  Created by 선민재 on 2022/12/28.
//

import UIKit
import Then
import SnapKit

class ProfileViewController: BaseViewController<ProfileViewModel> {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = ""
    }

    override func addView() {
        [].forEach {
            view.addSubview($0)
        }
    }
    
    override func setLayout() {
        
    }
}
