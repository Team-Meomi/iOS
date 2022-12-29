//
//  DetailViewController.swift
//  idea
//
//  Created by 선민재 on 2022/12/29.
//

import UIKit
import MSGLayout
import Then

class DetailViewController: BaseViewController<DetailViewModel> {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    let titleText = UILabel().then {
        $0.font = UIFont.SCFont(size: 18,family: .Medium)
        $0.textColor = .black
    }
    
    let contentText = UILabel().then {
        $0.font = UIFont.SCFont(size: 14,family: .Regular)
        $0.textColor = UIColor(red: 114/255, green: 111/255, blue: 111/255, alpha: 1)
    }
    
    let categoryText = UILabel().then {
        $0.font = UIFont.SCFont(size: 14,family: .Regular)
        $0.textColor = .black
    }
    
    let dateText = UILabel().then {
        $0.font = UIFont.SCFont(size: 14,family: .Regular)
        $0.textColor = .black
    }
    
    override func addView() {
        [titleText,contentText,categoryText,dateText].forEach {
            view.addSubview($0)
        }
    }
    
    override func setLayout() {
        MSGLayout.buildLayout {
            titleText.layout
                .top(.to(view).top, .equal(134))
                .leading(.to(view).leading, .equal(26))
            contentText.layout
                .top(.to(titleText).bottom, .equal(22))
                .leading(.to(view).leading, .equal(26))
            categoryText.layout
                .top(.to(contentText).bottom,.equal(26))
                .leading(.to(view).leading, .equal(26))
            dateText.layout
                .top(.to(categoryText).bottom,.equal(13))
                .leading(.to(view).leading, .equal(26))
        }
    }

}
