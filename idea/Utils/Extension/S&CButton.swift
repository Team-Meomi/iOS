//
//  S&CButton.swift
//  idea
//
//  Created by 선민재 on 2022/12/20.
//

import UIKit

extension UIButton {
    func paddingButton(margin: CGFloat) {
        let halfSize = margin/2
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -halfSize, bottom: 0, right: halfSize)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: halfSize, bottom: 0, right: -halfSize)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: halfSize, bottom: 0, right: halfSize)
    }
}
