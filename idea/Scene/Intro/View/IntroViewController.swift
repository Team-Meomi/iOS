//
//  ViewController.swift
//  idea
//
//  Created by 선민재 on 2022/12/07.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

class IntroViewController: BaseViewController<IntroViewModel> {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
    }
    
    override func addView() {
        [].forEach {
            view.addSubview($0)
        }
    }
    
    override func setLayout() {
        
    }

}
