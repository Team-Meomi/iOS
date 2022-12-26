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
    
    override  init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        addView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addView() {
        contentView.addSubview(titleText)
    }
    
    func setLayout() {
        titleText.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(47)
        }
    }
}
