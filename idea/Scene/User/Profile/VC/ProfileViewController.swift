//
//  ProfileViewController.swift
//  idea
//
//  Created by 선민재 on 2022/12/28.
//

import UIKit
import Then
import MSGLayout
import Moya
import RxSwift

class ProfileViewController: BaseViewController<ProfileViewModel> {
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getOpenedData()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.rightBarButtonItem = logoutBtn
        view.backgroundColor = .Background
    }
    
    lazy var logoutBtn: UIBarButtonItem = {
        var logout = UIImage(named: "logoutIcon.svg")
        logout = logout?.withRenderingMode(.alwaysOriginal)
        let logoutBtn = UIBarButtonItem(image: logout, style:.plain, target: self, action: #selector(logoutBtnDidTap))
        return logoutBtn
    }()
    
    let userImage = UIImageView().then {
        $0.image = UIImage(named: "profileImage.svg")
    }
    
    lazy var userNameText = UILabel().then {
        $0.font = UIFont.SCFont(size: 18,family: .Medium)
        $0.textColor = .black
    }
    
    lazy var openedBtn = UIButton().then {
        let text = NSAttributedString(string: "개설한")
        $0.setAttributedTitle(text, for: .normal)
        $0.titleLabel?.font = UIFont.SCFont(size: 14, family: .Medium)
        $0.setTitleColor(UIColor.Main, for: .normal)
        $0.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        $0.layer.cornerRadius = 5
        $0.addTarget(self, action: #selector(openedBtnDidTap), for: .touchUpInside)
    }
    
    lazy var appliedBtn = UIButton().then {
        let text = NSAttributedString(string: "신청한")
        $0.setAttributedTitle(text, for: .normal)
        $0.titleLabel?.font = UIFont.SCFont(size: 14, family: .Medium)
        $0.setTitleColor(UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1), for: .normal)
        $0.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        $0.layer.cornerRadius = 5
        $0.addTarget(self, action: #selector(appliedBtnDidTap), for: .touchUpInside)
    }
    
    let divisionLine = UIView().then {
        $0.backgroundColor = .Main
        $0.layer.cornerRadius = 4
    }
    
    let userTableView = UITableView().then {
        $0.register(MainTabelViewCell.self, forCellReuseIdentifier: "MainTabelViewCell")
        $0.separatorStyle = .none
        $0.rowHeight = 75
        $0.layer.cornerRadius = 8
    }
    
    @objc func logoutBtnDidTap() {
        viewModel.pushIntro()
    }
    
    @objc func openedBtnDidTap() {
        openedBtn.setTitleColor(UIColor.Main, for: .normal)
        appliedBtn.setTitleColor(UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1), for: .normal)
    }

    @objc func appliedBtnDidTap() {
        appliedBtn.setTitleColor(UIColor.Main, for: .normal)
        openedBtn.setTitleColor(UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1), for: .normal)
    }
    
    override func addView() {
        [userImage,userNameText,openedBtn,appliedBtn,divisionLine,userTableView].forEach {
            view.addSubview($0)
        }
    }
    
    func getOpenedData() {
        // MARK: Input
        let viewWillApeearObservable = self.rx.methodInvoked(#selector(viewWillAppear))
            .map { _ in }
            .asObservable()
        
        // MARK: Output
        let output = viewModel.transform(
            .init(
                viewWillAppear: viewWillApeearObservable,
                selectButtonDidTap: Observable.create { [weak self] observer in
                    guard let self = self else { return Disposables.create() }
                    var disposables = [Disposable]()
                    disposables.append(
                        self.openedBtn.rx.tap
                            .bind(with: self) { owner, _ in
                                observer.onNext(.opened)
                            }
                    )
                    disposables.append(
                        self.appliedBtn.rx.tap
                            .bind(with: self) { owner, _ in
                                observer.onNext(.joined)
                            }
                    )
                    return Disposables.create(disposables)
                }
            )
        )
        output.currentSelected
            .flatMap { $0 == .opened ? output.writtenList : output.joinedList }
            .bind(
                to: userTableView.rx.items(cellIdentifier: "MainTabelViewCell", cellType: MainTabelViewCell.self)
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
        
        output.profile
            .catchAndReturn(.init(id: 0, name: "", stuNum: 0))
            .map { "\($0.stuNum)\($0.name)" }
            .bind(to: userNameText.rx.text)
            .disposed(by: disposeBag)
    }
    
    override func setLayout() {
        MSGLayout.buildLayout {
            userImage.layout
                .top(.to(view).top, .equal((bounds.height) / 9.55))
                .centerX(.toSuperview())
            userNameText.layout
                .top(.to(userImage).bottom, .equal(4))
                .centerX(.toSuperview())
            openedBtn.layout
                .top(.to(userNameText).bottom, .equal((bounds.height) / 15.16))
                .leading(.to(view).leading, .equal((bounds.width) / 3.75))
            appliedBtn.layout
                .top(.to(userNameText).bottom, .equal((bounds.height) / 15.16))
                .trailing(.to(view).trailing, .equal(-(bounds.width) / 3.75))
            divisionLine.layout
                .top(.to(userNameText).bottom, .equal((bounds.height) / 17.276))
                .centerX(.toSuperview())
                .width(3)
                .height(30)
            userTableView.layout
                .top(.to(divisionLine).bottom, .equal(18))
                .centerX(.toSuperview())
                .leading(.to(view).leading, .equal(33))
                .trailing(.to(view).trailing, .equal(-33))
                .bottom(.toSuperview())
        }
    }
}
