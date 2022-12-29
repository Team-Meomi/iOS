//
//  MainTableViewCell.swift
//  idea
//
//  Created by 선민재 on 2022/12/26.
//

import UIKit
import Then
import SnapKit

class MainTabelViewCell: UITableViewCell {
    
    let titleText = UILabel().then {
        $0.font = UIFont.SCFont(size: 14, family:.Medium)
        $0.numberOfLines = 1
    }
    
    let typeText = UILabel().then {
        $0.font = UIFont.SCFont(size: 12,family:.Medium)
        $0.textColor = .TypeColor
    }
    
    let dateText = UILabel().then {
        $0.font = UIFont.SCFont(size: 12,family: .Medium)
        $0.textColor = UIColor(red: 124/255, green: 124/255, blue: 124/255, alpha: 1)
    }
    
    let categoryView = UIView().then {
        $0.backgroundColor = .AOS
        $0.layer.cornerRadius = 5
    }
    
    let categoryText = UILabel().then {
        $0.font = UIFont.SCFont(size:12 ,family: .Medium)
        $0.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
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
        [typeText,titleText,dateText,categoryText,categoryView].forEach{
            contentView.addSubview($0)
        }
    }
    
    func setLayout() {
        typeText.snp.makeConstraints {
            $0.top.equalToSuperview().offset(14)
            $0.trailing.equalToSuperview().inset(24)
        }
        titleText.snp.makeConstraints {
            $0.top.equalToSuperview().offset(13)
            $0.leading.equalToSuperview().inset(14)
            $0.trailing.equalToSuperview().inset(75)
        }
        dateText.snp.makeConstraints {
            $0.top.equalTo(typeText.snp.bottom).offset(14)
            $0.trailing.equalToSuperview().inset(14)
        }
        categoryText.snp.makeConstraints {
            $0.top.equalTo(titleText.snp.bottom).offset(12)
            $0.leading.equalTo(categoryView.snp.trailing).offset(4)
        }
        categoryView.snp.makeConstraints {
            $0.centerY.equalTo(categoryText.snp.centerY).offset(0)
            $0.leading.equalToSuperview().offset(14)
            $0.height.equalTo(10)
            $0.width.equalTo(10)
        }
    }
}
