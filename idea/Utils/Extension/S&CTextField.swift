//
//  S&CTextField.swift
//  idea
//
//  Created by 선민재 on 2022/12/15.
//

import UIKit

extension UITextField {
    func addLeftPadding(width:Float) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: CGFloat(width), height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }

    func addRightImage(_ image: UIImage, x: Float, y: Float) {
        let iconView = UIImageView(frame:CGRect(x: CGFloat(x), y: CGFloat(y), width: image.size.width, height: image.size.height))
        iconView.image = image
        iconView.tintColor = .Main
        let iconContainerView: UIView = UIView(frame:CGRect(x: 0, y: 0, width: 28, height: 28))
        iconContainerView.addSubview(iconView)
        rightView = iconContainerView
        rightViewMode = .always
    }
}
