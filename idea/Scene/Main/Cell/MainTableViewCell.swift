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
        $0.layer.cornerRadius = 50
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
        [titleText,typeText,dateText,categoryView,categoryText].forEach{
            contentView.addSubview($0)
        }
    }
    
    func setLayout() {
        titleText.snp.makeConstraints {
            $0.top.equalToSuperview().offset(13)
            $0.leading.equalToSuperview().inset(14)
        }
        typeText.snp.makeConstraints {
            $0.top.equalToSuperview().offset(14)
            $0.trailing.equalToSuperview().inset(24)
        }
        dateText.snp.makeConstraints {
            $0.top.equalTo(typeText.snp.bottom).offset(14)
            $0.trailing.equalToSuperview().inset(14)
        }
        categoryView.snp.makeConstraints {
            $0.top.equalTo(titleText.snp.bottom).offset(18)
            $0.leading.equalToSuperview().offset(14)
            $0.height.equalTo(6)
            $0.width.equalTo(6)
        }
        categoryText.snp.makeConstraints {
            $0.top.equalTo(titleText.snp.bottom).offset(12)
            $0.leading.equalTo(categoryView.snp.trailing).offset(4)
        }
    }
}
