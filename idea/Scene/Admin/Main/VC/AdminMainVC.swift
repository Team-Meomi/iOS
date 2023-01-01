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
    lazy var conBtn = UIButton().then {
        let text = NSAttributedString(string: "컨퍼런스")
        $0.setAttributedTitle(text, for: .normal)
        $0.titleLabel?.font = UIFont.SCFont(size: 14, family: .Medium)
        $0.setTitleColor(UIColor.Main, for: .normal)
        $0.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        $0.layer.cornerRadius = 5
        $0.addTarget(self, action: #selector(conBtnDidTap), for: .touchUpInside)
    }
    
    lazy var studyBtn = UIButton().then {
        let text = NSAttributedString(string: "스터디")
        $0.setAttributedTitle(text, for: .normal)
        $0.titleLabel?.font = UIFont.SCFont(size: 14, family: .Medium)
        $0.setTitleColor(UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1), for: .normal)
        $0.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        $0.layer.cornerRadius = 5
        $0.addTarget(self, action: #selector(studyBtnDidTap), for: .touchUpInside)
    }
    
    let divisionLine = UIView().then {
        $0.backgroundColor = .Main
        $0.layer.cornerRadius = 4
    }
    
    @objc func conBtnDidTap() {
        conBtn.setTitleColor(UIColor.Main, for: .normal)
        studyBtn.setTitleColor(UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1), for: .normal)
    }

    @objc func studyBtnDidTap() {
        studyBtn.setTitleColor(UIColor.Main, for: .normal)
        conBtn.setTitleColor(UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1), for: .normal)
    }
    
    override func addView() {
        [titleDateText,explainText,conBtn,divisionLine,studyBtn].forEach {
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
            conBtn.layout
                .top(.to(explainText).bottom, .equal((bounds.height) / 6.15))
                .leading(.to(view).leading, .equal((bounds.width) / 4.36))
            divisionLine.layout
                .top(.to(view).top, .equal(239))
                .centerX(.toSuperview())
                .width(3)
                .height(30)
            studyBtn.layout
                .top(.to(explainText).bottom, .equal((bounds.height) / 6.15))
                .trailing(.to(view).trailing, .equal(-(bounds.width) / 3.9))
        }
    }

}
