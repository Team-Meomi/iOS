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
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = profileImage
        self.navigationItem.leftBarButtonItem = searchImage
        self.navigationItem.title = "S&C"
        getData()
    }
    
    lazy var profileImage: UIBarButtonItem = {
        var profile = UIImage(named: "profileIcon.svg")
        profile = profile?.withRenderingMode(.alwaysOriginal)
        let profileBtn = UIBarButtonItem(image: profile, style:.plain, target: self, action: #selector(profileBtnDidTap(_:)))
        return profileBtn
    }()
    
    lazy var searchImage: UIBarButtonItem = {
        var search = UIImage(named: "searchIcon.svg")
        search = search?.withRenderingMode(.alwaysOriginal)
        let searchBtn = UIBarButtonItem(image: search, style:.plain, target: self, action: #selector(searchBtnDidTap(_:)))
        return searchBtn
    }()
    
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
    
    @objc func searchBtnDidTap(_ sender: Any) {
        print("h1")
        viewModel.pushSearch()
    }
    
    @objc func profileBtnDidTap(_ sender: Any) {
        print("h2")
        viewModel.pushProfile()
    }
    
    override func addView() {
        [createconBtn,conText,conImage,conPlusImage,createstudyBtn,studyText,studyImage,studyPlusImage,mainTableView].forEach {
            view.addSubview($0)
        }
    }
    
    func getData() {
        // MARK: Input
        let viewWillApeearObservable = self.rx.methodInvoked(#selector(viewWillAppear))
            .map { _ in }
            .asObservable()
        
        let mainCellSelectedObservable = mainTableView.rx.modelSelected(ListResponse.self)
            .asObservable()
            .map(\.id)
        
        // MARK: Output
        let output = viewModel.transform(
            .init(
                viewWillAppear: viewWillApeearObservable,
                conferenceCellDidselect: mainCellSelectedObservable
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
                switch item.category {
                case "FE":
                    cell.categoryView.backgroundColor = .FE
                    break
                case "BE":
                    cell.categoryView.backgroundColor = .BE
                    break
                case "iOS":
                    cell.categoryView.backgroundColor = .iOS
                    break
                case "AOS":
                    cell.categoryView.backgroundColor = .AOS
                    break
                case "기타":
                    cell.categoryView.backgroundColor = .Etc
                    break
                default:
                    cell.categoryView.backgroundColor = .Etc
                    break
                }
                cell.accessoryType = .disclosureIndicator
            }
            .disposed(by: disposeBag)
    }
    
    override func setLayout() {
        createconBtn.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).offset(127)
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
            $0.top.equalTo(view.snp.top).offset(127)
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
