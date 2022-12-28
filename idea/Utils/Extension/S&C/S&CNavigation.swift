//
//  S&CNavigation.swift
//  idea
//
//  Created by 선민재 on 2022/12/28.
//

import Foundation
import UIKit


extension UINavigationItem{
    func logoutImage() {
        var profile = UIImage(named: "logoutIcon.svg")
        profile = profile?.withRenderingMode(.alwaysOriginal)
        self.rightBarButtonItem = UIBarButtonItem(image: profile, style:.plain, target: nil, action: nil)
    }
}
