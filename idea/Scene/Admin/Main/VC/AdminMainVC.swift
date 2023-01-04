//
//  AdminMainVC.swift
//  idea
//
//  Created by 선민재 on 2023/01/02.
//

import UIKit
import MSGLayout
import Then
import RxCocoa
import RxSwift
import Moya

class AdminMainVC: BaseViewController<AdminMainVM> {
    private let disposeBag = DisposeBag()

    let nowDate = Date()
    let dateFormatter = DateFormatter().then {
        $0.dateFormat = "yyyy-MM-dd"
    }
    lazy var nowDateStr = dateFormatter.string(from: nowDate)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getConData()
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
    
    let userTableView = UITableView().then {
        $0.register(AdminMainTableViewCell.self, forCellReuseIdentifier: "AdminMainTableViewCell")
        $0.separatorStyle = .none
        $0.rowHeight = 75
        $0.layer.cornerRadius = 8
    }
    
    func getConData() {
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
                        self.conBtn.rx.tap
                            .bind(with: self) { owner, _ in
                                observer.onNext(.con)
                            }
                    )
                    disposables.append(
                        self.studyBtn.rx.tap
                            .bind(with: self) { owner, _ in
                                observer.onNext(.study)
                            }
                    )
                    return Disposables.create(disposables)
                }
            )
        )
        output.currentSelected
            .flatMap { $0 == .con ? output.conList : output.studyList }
            .bind(
                to: userTableView.rx.items(cellIdentifier: "AdminMainTableViewCell", cellType: AdminMainTableViewCell.self)
            ) { ip, item, cell in
                cell.listUser.text = "\(item.stuNum)\(item.name)"
                cell.accessoryType = .disclosureIndicator
            }
            .disposed(by: disposeBag)
    }
    
    
    override func addView() {
        [titleDateText,explainText,conBtn,divisionLine,studyBtn,userTableView].forEach {
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
            userTableView.layout
                .top(.to(studyBtn).bottom, .equal(43))
                .centerX(.toSuperview())
                .leading(.to(view).leading, .equal(55))
                .trailing(.to(view).trailing, .equal(-55))
                .bottom(.toSuperview())
        }
    }

}
