//
//  SearchViewController.swift
//  idea
//
//  Created by 선민재 on 2022/12/27.
//

import UIKit
import Then
import SnapKit

class SearchViewController: BaseViewController<SearchViewModel> {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "스터디"
        self.navigationController?.navigationBar.topItem?.title = ""
        addScrollView()
        setScrollViewLayout()
    }
    
    let scrollView = UIScrollView().then {
        $0.backgroundColor = .Background
    }
    
    let searchTextField = UITextField().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.Main?.cgColor
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        $0.font = UIFont.SCFont(size: 12,family:.Regular)
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        $0.addRightImage(UIImage(systemName: "magnifyingglass")!, x: -5.5, y: 3.5)
        $0.addLeftPadding(width: 18)
    }

    override func addView() {
        [scrollView].forEach {
            view.addSubview($0)
        }
    }
    
    
    func addScrollView() {
        [searchTextField].forEach {
            scrollView.addSubview($0)
        }
    }
    
    override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    func setScrollViewLayout() {
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.top).offset(15)
            $0.centerX.equalToSuperview()
            $0.trailing.leading.equalToSuperview().inset(33)
            $0.height.equalTo(40)
        }
    }
}
