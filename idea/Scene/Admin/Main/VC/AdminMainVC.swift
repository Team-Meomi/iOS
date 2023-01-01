//
//  AdminMainVC.swift
//  idea
//
//  Created by 선민재 on 2023/01/02.
//

import UIKit
import MSGLayout
import Then
import Foundation
import DropDown

class AdminMainVC: BaseViewController<AdminMainVM> {

    let nowDate = Date()
    let dateFormatter = DateFormatter().then {
        $0.dateFormat = "yyyy-MM-dd"
    }
    lazy var nowDateStr = dateFormatter.string(from: nowDate)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
    }
    
    lazy var titleDateText = UILabel().then {
        $0.text = nowDateStr
        $0.font = UIFont.SCFont(size: 16,family:.Bold)
        $0.textColor = .black
    }
    
    let explainText = UILabel().then {
        $0.text = "컨퍼런스와 스터디 목록입니다"
        $0.font = UIFont.SCFont(size: 16,family:.Bold)
        $0.textColor = .black
    }
        
//    let gradeDropDown = DropDown().then {
//        DropDown.appearance().textColor = UIColor.black // 아이템 텍스트 색상
//        DropDown.appearance().selectedTextColor = UIColor.blue // 선택된 아이템 텍스트 색상
//        DropDown.appearance().backgroundColor = UIColor.white // 아이템 팝업 배경 색상
//        DropDown.appearance().selectionBackgroundColor = UIColor.lightGray // 선택한 아이템 배경 색상
//        DropDown.appearance().setupCornerRadius(8)
//        $0.backgroundColor = UIColor.init(named: "#F1F1F1")
//        $0.layer.cornerRadius = 8
//        $0.dataSource = ["1학년","2학년","3학년"]
//        $0.show()
//    }
    override func addView() {
        [titleDateText,explainText].forEach {
            view.addSubview($0)
        }
    }
    
    override func setLayout() {
        MSGLayout.buildLayout {
            titleDateText.layout
                .top(.to(view).top, .equal(57))
                .centerX(.toSuperview())
            explainText.layout
                .top(.to(titleDateText).bottom, .equal(9))
                .centerX(.toSuperview())
        }
    }

}
