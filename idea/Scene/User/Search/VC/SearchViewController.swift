//
//  SearchViewController.swift
//  idea
//
//  Created by 선민재 on 2022/12/27.
//

import UIKit
import Then
import SnapKit
import RxCocoa
import RxSwift

class SearchViewController: BaseViewController<SearchViewModel> {
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "검색하기"
        self.navigationController?.navigationBar.topItem?.title = ""
//        configureVC()
    }
    
    var guardFeTap:Bool = false
    var guardBeTap:Bool = false
    var guardiOSTap:Bool = false
    var guardAosTap:Bool = false
    var guardEtcTap:Bool = false
    
    let searchTextField = UITextField().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.Main?.cgColor
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        $0.font = UIFont.SCFont(size: 12,family:.Regular)
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        $0.addLeftPadding(width: 18)
        $0.addRightPadding(width: 50)
    }
    
    lazy var searchBtn = UIButton().then {
        $0.setImage(UIImage(named: "searchIcon.svg"), for: .normal)
        $0.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(searchBtnDidTap), for: .touchUpInside)
    }
    
    lazy var feBtn = UIButton().then {
        let text = NSAttributedString(string: "FE")
        $0.setAttributedTitle(text, for: .normal)
        $0.titleLabel?.font = UIFont.SCFont(size: 12, family: .Bold)
        $0.setTitleColor(UIColor(red: 82/255, green: 82/255, blue: 87/255, alpha: 1), for: .normal)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.layer.borderColor = UIColor.Main?.cgColor
        $0.layer.borderWidth = 1
        $0.addTarget(self, action: #selector(feBtnDidTap), for: .touchUpInside)
    }
    
    lazy var beBtn = UIButton().then {
        let text = NSAttributedString(string: "BE")
        $0.setAttributedTitle(text, for: .normal)
        $0.titleLabel?.font = UIFont.SCFont(size: 12, family: .Bold)
        $0.setTitleColor(UIColor(red: 82/255, green: 82/255, blue: 87/255, alpha: 1), for: .normal)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.layer.borderColor = UIColor.Main?.cgColor
        $0.layer.borderWidth = 1
        $0.addTarget(self, action: #selector(beBtnDidTap), for: .touchUpInside)
    }
    
    lazy var iosBtn = UIButton().then {
        let text = NSAttributedString(string: "iOS")
        $0.setAttributedTitle(text, for: .normal)
        $0.titleLabel?.font = UIFont.SCFont(size: 12, family: .Bold)
        $0.setTitleColor(UIColor(red: 82/255, green: 82/255, blue: 87/255, alpha: 1), for: .normal)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.layer.borderColor = UIColor.Main?.cgColor
        $0.layer.borderWidth = 1
        $0.addTarget(self, action: #selector(iOSBtnDidTap), for: .touchUpInside)
    }
    
    lazy var aosBtn = UIButton().then {
        let text = NSAttributedString(string: "AOS")
        $0.setAttributedTitle(text, for: .normal)
        $0.titleLabel?.font = UIFont.SCFont(size: 12, family: .Bold)
        $0.setTitleColor(UIColor(red: 82/255, green: 82/255, blue: 87/255, alpha: 1), for: .normal)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.layer.borderColor = UIColor.Main?.cgColor
        $0.layer.borderWidth = 1
        $0.addTarget(self, action: #selector(aosBtnDidTap), for: .touchUpInside)
    }
    
    lazy var etcBtn = UIButton().then {
        let text = NSAttributedString(string: "기타")
        $0.setAttributedTitle(text, for: .normal)
        $0.titleLabel?.font = UIFont.SCFont(size: 12, family: .Bold)
        $0.setTitleColor(UIColor(red: 82/255, green: 82/255, blue: 87/255, alpha: 1), for: .normal)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.layer.borderColor = UIColor.Main?.cgColor
        $0.layer.borderWidth = 1
        $0.addTarget(self, action: #selector(etcBtnDidTap), for: .touchUpInside)
    }
    
    let searchTableView = UITableView().then {
        $0.register(MainTabelViewCell.self, forCellReuseIdentifier: "MainTabelViewCell")
        $0.separatorStyle = .none
        $0.rowHeight = 75
        $0.layer.cornerRadius = 8
    }

//    func configureVC() {
//        view.backgroundColor = .white
//        searchTableView.dataSource = self
//        searchTableView.delegate = self
//    }
    
    func getSearch() {
        // MARK: Input
        let viewWillApeearObservable = searchBtn.rx.tap
            .map { _ in }
            .asObservable()

        let searchCellSelectedObservable = searchTableView.rx.modelSelected(SearchResponse.self)
            .asObservable()
            .map(\.id)

        // MARK: Output
        let output = viewModel.transform(
            .init(
                searchBtnDidTap: viewWillApeearObservable,
                conferenceCellDidselect: searchCellSelectedObservable
            )
        )
        
        self.searchTableView.delegate = nil
        self.searchTableView.dataSource = nil
    
        output.search
            .bind(
                to: searchTableView.rx.items(cellIdentifier: "MainTabelViewCell", cellType: MainTabelViewCell.self)
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
    
    @objc func searchBtnDidTap() {
        BaseVC.searchText = searchTextField.text ?? ""
        self.getSearch()
    }
    
    @objc func feBtnDidTap() {
        guard guardFeTap != true else{
            feBtn.setTitleColor(UIColor(red: 82/255, green: 82/255, blue: 87/255, alpha: 1), for: .normal)
            feBtn.layer.borderColor = UIColor.Main?.cgColor
            feBtn.layer.borderWidth = 1
            feBtn.backgroundColor = .white
            BaseVC.searchMajor = ""
            self.guardFeTap = false
            return
        }
        guard guardBeTap != true && guardiOSTap != true && guardAosTap != true && guardEtcTap != true else{return}
        feBtn.layer.borderColor = UIColor.FE?.cgColor
        feBtn.backgroundColor = .FE
        feBtn.setTitleColor(UIColor.white,for: .normal)
        BaseVC.searchMajor = "FE"
        self.guardFeTap = true
    }
    
    @objc func beBtnDidTap() {
        guard guardBeTap != true else{
            beBtn.setTitleColor(UIColor(red: 82/255, green: 82/255, blue: 87/255, alpha: 1), for: .normal)
            beBtn.layer.borderColor = UIColor.Main?.cgColor
            beBtn.layer.borderWidth = 1
            beBtn.backgroundColor = .white
            BaseVC.searchMajor = ""
            self.guardBeTap = false
            return
        }
        guard guardFeTap != true && guardiOSTap != true && guardAosTap != true && guardEtcTap != true else{return}
        beBtn.layer.borderColor = UIColor.BE?.cgColor
        beBtn.backgroundColor = .BE
        beBtn.setTitleColor(UIColor.white,for: .normal)
        BaseVC.searchMajor = "BE"
        self.guardBeTap = true
    }
    
    @objc func iOSBtnDidTap() {
        guard guardiOSTap != true else{
            iosBtn.setTitleColor(UIColor(red: 82/255, green: 82/255, blue: 87/255, alpha: 1), for: .normal)
            iosBtn.layer.borderColor = UIColor.Main?.cgColor
            iosBtn.layer.borderWidth = 1
            iosBtn.backgroundColor = .white
            BaseVC.searchMajor = ""
            self.guardiOSTap = false
            return
        }
        guard guardFeTap != true && guardBeTap != true && guardAosTap != true && guardEtcTap != true else{return}
        iosBtn.layer.borderColor = UIColor.iOS?.cgColor
        iosBtn.backgroundColor = .iOS
        iosBtn.setTitleColor(UIColor.white,for: .normal)
        BaseVC.searchMajor = "iOS"
        self.guardiOSTap = true
    }
    
    @objc func aosBtnDidTap() {
        guard guardAosTap != true else{
            aosBtn.setTitleColor(UIColor(red: 82/255, green: 82/255, blue: 87/255, alpha: 1), for: .normal)
            aosBtn.layer.borderColor = UIColor.Main?.cgColor
            aosBtn.layer.borderWidth = 1
            aosBtn.backgroundColor = .white
            BaseVC.searchMajor = ""
            self.guardAosTap = false
            return
        }
        guard guardFeTap != true && guardBeTap != true && guardiOSTap != true && guardEtcTap != true else{return}
        aosBtn.layer.borderColor = UIColor.AOS?.cgColor
        aosBtn.backgroundColor = .AOS
        aosBtn.setTitleColor(UIColor.white,for: .normal)
        BaseVC.searchMajor = "AOS"
        self.guardAosTap = true
    }
    
    @objc func etcBtnDidTap() {
        guard guardEtcTap != true else{
            etcBtn.setTitleColor(UIColor(red: 82/255, green: 82/255, blue: 87/255, alpha: 1), for: .normal)
            etcBtn.layer.borderColor = UIColor.Main?.cgColor
            etcBtn.layer.borderWidth = 1
            etcBtn.backgroundColor = .white
            BaseVC.searchMajor = ""
            self.guardEtcTap = false
            return
        }
        guard guardFeTap != true && guardBeTap != true && guardiOSTap != true && guardAosTap != true else{return}
        etcBtn.layer.borderColor = UIColor.Etc?.cgColor
        etcBtn.backgroundColor = .Etc
        etcBtn.setTitleColor(UIColor.white,for: .normal)
        BaseVC.searchMajor = "기타"
        self.guardEtcTap = true
    }

    override func addView() {
        [searchTextField,searchBtn,feBtn,beBtn,iosBtn,aosBtn,etcBtn,searchTableView].forEach {
            view.addSubview($0)
        }
    }
    
    override func setLayout() {
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).offset((bounds.height) / 7.38)
            $0.centerX.equalToSuperview()
            $0.trailing.leading.equalToSuperview().inset(33)
            $0.height.equalTo(40)
        }
        searchBtn.snp.makeConstraints {
            $0.centerY.equalTo(searchTextField.snp.centerY).offset(0)
            $0.trailing.equalTo(view.snp.trailing).inset(33)
            $0.leading.equalTo(searchTextField.snp.trailing).inset(40)
            $0.height.width.equalTo(40)
        }
        feBtn.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(24)
            $0.leading.equalTo(view.snp.leading).offset(33)
            $0.height.equalTo(35)
            $0.width.equalTo(52)
        }
        beBtn.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(24)
            $0.leading.equalTo(feBtn.snp.trailing).offset(12)
            $0.height.equalTo(35)
            $0.width.equalTo(52)
        }
        iosBtn.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(24)
            $0.leading.equalTo(beBtn.snp.trailing).offset(12)
            $0.height.equalTo(35)
            $0.width.equalTo(52)
        }
        aosBtn.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(24)
            $0.leading.equalTo(iosBtn.snp.trailing).offset(12)
            $0.height.equalTo(35)
            $0.width.equalTo(52)
        }
        etcBtn.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(24)
            $0.leading.equalTo(aosBtn.snp.trailing).offset(12)
            $0.height.equalTo(35)
            $0.width.equalTo(52)
        }
        searchTableView.snp.makeConstraints {
            $0.top.equalTo(etcBtn.snp.bottom).offset(22)
            $0.leading.trailing.equalToSuperview().inset(33)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
}

//extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        BaseVC.searchDecoedeData?.count ?? 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTabelViewCell", for: indexPath) as? MainTabelViewCell else { return UITableViewCell()}
//        cell.titleText.text = BaseVC.searchDecoedeData?[indexPath.row].title
//        cell.categoryText.text = BaseVC.searchDecoedeData?[indexPath.row].category
//        cell.typeText.text = BaseVC.searchDecoedeData?[indexPath.row].type
//        cell.dateText.text = BaseVC.searchDecoedeData?[indexPath.row].date
//        cell.accessoryType = .disclosureIndicator
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////        viewModel.cellDidSelect(index: indexPath.row)
//    }
//}
//
//
