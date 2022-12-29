//
//  MainViewController.swift
//  idea
//
//  Created by 선민재 on 2022/12/23.
//

import UIKit
import Then
import RxSwift
import SnapKit

class MainViewController: BaseViewController<MainViewModel> {
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        List()
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        getData()
    }
    
    lazy var profileBtn = UIButton().then {
        $0.setImage(UIImage(named: "profileIcon.svg"), for: .normal)
        $0.tintColor = .Main
        $0.addTarget(self, action: #selector(profileBtnDidTap), for: .touchUpInside)
    }
    
    lazy var searchBtn = UIButton().then {
        $0.setImage(UIImage(named: "searchIcon.svg"), for: .normal)
        $0.tintColor = .Main
        $0.layer.cornerRadius = 50
        $0.addTarget(self, action: #selector(searchBtnDidTap), for: .touchUpInside)
    }
    
    lazy var createconBtn = UIButton().then {
        $0.backgroundColor = .LightMain
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(createconBtnDidTap), for: .touchUpInside)
    }
    
    let conText = UILabel().then {
        $0.text = "컨퍼런스\n만들기"
        $0.font = UIFont.SCFont(size:22, family:.Regular)
        $0.numberOfLines = 2
    }
    
    let conImage = UIImageView().then {
        $0.image = UIImage(named: "conImage.svg")
    }
    
    let conPlusImage = UIImageView().then {
        $0.image = UIImage(systemName: "plus.circle")
        $0.tintColor = .black
    }
    
    lazy var createstudyBtn = UIButton().then {
        $0.backgroundColor = .LightMain
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(createstudyBtnDidTap), for: .touchUpInside)
    }
    
    let studyText = UILabel().then {
        $0.text = "스터디\n만들기"
        $0.font = UIFont.SCFont(size:22, family:.Regular)
        $0.numberOfLines = 2
    }
    
    let studyImage = UIImageView().then {
        $0.image = UIImage(named: "studyImage.svg")
    }
    
    let studyPlusImage = UIImageView().then {
        $0.image = UIImage(systemName: "plus.circle")
        $0.tintColor = .black
    }
    
    let myText = UILabel().then {
        $0.text = "My"
        $0.font = UIFont.SCFont(size:12,family:.Medium)
        $0.textColor = .Main
    }
    
    let mainTableView = UITableView().then {
        $0.register(MainTabelViewCell.self, forCellReuseIdentifier: "MainTabelViewCell")
        $0.separatorStyle = .none
        $0.rowHeight = 75
        $0.layer.cornerRadius = 8
    }
    
    @objc func createconBtnDidTap() {
        viewModel.pushCreateCon()
    }
    
    @objc func createstudyBtnDidTap() {
        viewModel.pushCreateStu()
    }

    @objc func searchBtnDidTap() {
        viewModel.pushSearch()
    }
    
    @objc func profileBtnDidTap() {
        viewModel.pushProfile()
    }
    
    override func addView() {
        [profileBtn,searchBtn,createconBtn,conText,conImage,conPlusImage,createstudyBtn,studyText,studyImage,studyPlusImage,myText,mainTableView].forEach {
            view.addSubview($0)
        }
    }
    
    func getData() {
        // MARK: Input
        let viewWillApeearObservable = self.rx.methodInvoked(#selector(viewWillAppear))
            .map { _ in }
            .asObservable()
        
        // MARK: Output
        let output = viewModel.transform(
            .init(
                viewWillAppear: viewWillApeearObservable
            )
        )
        
        output.list
            .bind(
                to: mainTableView.rx.items(cellIdentifier: "MainTabelViewCell", cellType: MainTabelViewCell.self)
            ) { ip, item, cell in
                cell.titleText.text = item.title
                cell.categoryText.text = item.category
                cell.typeText.text = item.type
                cell.dateText.text = item.date
                cell.accessoryType = .disclosureIndicator
            }
            .disposed(by: disposeBag)
    }
    
    override func setLayout() {
        profileBtn.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).offset(61)
            $0.trailing.equalTo(view.snp.trailing).inset(33)
            $0.height.equalTo(31)
            $0.width.equalTo(31)
        }
        searchBtn.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).offset(61)
            $0.trailing.equalTo(profileBtn.snp.leading).inset(-10)
            $0.height.equalTo(31)
            $0.width.equalTo(31)
        }
        myText.snp.makeConstraints {
            $0.top.equalTo(profileBtn.snp.bottom).offset(0)
            $0.centerX.equalTo(profileBtn.snp.centerX).offset(0)
        }
        createconBtn.snp.makeConstraints {
            $0.top.equalTo(myText.snp.bottom).offset(25)
            $0.leading.equalTo(view.snp.leading).offset(33)
            $0.height.width.equalTo(140)
        }
        conText.snp.makeConstraints {
            $0.top.equalTo(createconBtn.snp.top).offset(12)
            $0.leading.equalTo(createconBtn.snp.leading).offset(15)
        }
        conImage.snp.makeConstraints {
            $0.top.equalTo(conText.snp.bottom).offset(6)
            $0.leading.equalTo(createconBtn.snp.leading).inset(-18)
        }
        conPlusImage.snp.makeConstraints {
            $0.bottom.equalTo(createconBtn.snp.bottom).inset(7)
            $0.trailing.equalTo(createconBtn.snp.trailing).inset(7)
            $0.height.width.equalTo(28)
        }
        createstudyBtn.snp.makeConstraints {
            $0.top.equalTo(myText.snp.bottom).offset(25)
            $0.trailing.equalTo(view.snp.trailing).inset(33)
            $0.height.width.equalTo(140)
        }
        studyText.snp.makeConstraints {
            $0.top.equalTo(createstudyBtn.snp.top).offset(12)
            $0.leading.equalTo(createstudyBtn.snp.leading).offset(14)
        }
        studyImage.snp.makeConstraints {
            $0.leading.equalTo(createstudyBtn.snp.leading).offset(10)
            $0.bottom.equalTo(createstudyBtn.snp.bottom).offset(0)
        }
        studyPlusImage.snp.makeConstraints {
            $0.bottom.equalTo(createstudyBtn.snp.bottom).inset(7)
            $0.trailing.equalTo(createstudyBtn.snp.trailing).inset(7)
            $0.height.width.equalTo(28)
        }
        mainTableView.snp.makeConstraints {
            $0.top.equalTo(createstudyBtn.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(33)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
