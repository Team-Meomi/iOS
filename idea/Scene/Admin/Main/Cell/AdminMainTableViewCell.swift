//
//  AdminMainTableViewCell.swift
//  idea
//
//  Created by 선민재 on 2023/01/02.
//

import UIKit
import Then
import MSGLayout

class AdminMainTableViewCell: UITableViewCell {
    
    let listImage = UIImageView().then {
        $0.image = UIImage(named: "listImage.svg")
    }
    
    let listUser = UILabel().then {
        $0.font = UIFont.SCFont(size: 14,family: .Medium)
        $0.textColor = .Main
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addView() {
        [listImage,listUser].forEach{
            contentView.addSubview($0)
        }
    }
    
    func setLayout() {
        MSGLayout.buildLayout {
            listImage.layout
                .centerY(.toSuperview())
                .leading(.toSuperview(), .equal(8))
            listUser.layout
                .centerY(.toSuperview())
                .leading(.to(listImage).trailing, .equal(10))
        }
    }
}
