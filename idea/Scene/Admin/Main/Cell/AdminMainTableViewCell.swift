//
//  AdminMainTableViewCell.swift
//  idea
//
//  Created by 선민재 on 2023/01/02.
//

import UIKit
import Then
import MSGLayout

class AdminMainTableView: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addView() {
        [].forEach{
            contentView.addSubview($0)
        }
    }
    
    func setLayout() {
        MSGLayout.buildLayout {
            
        }
    }
}
