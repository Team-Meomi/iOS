//
//  S&CFont.swift
//  idea
//
//  Created by 선민재 on 2022/12/15.
//

import UIKit

extension UIFont {
    
    enum Family: String {
        case Bold, Medium, Regular, Black, Light, Thin
    }
    
    static func SCFont(size: CGFloat = 10, family: Family = .Regular) -> UIFont {
        return UIFont(name: "NotoSansKR-\(family)", size: size)!
    }
}
