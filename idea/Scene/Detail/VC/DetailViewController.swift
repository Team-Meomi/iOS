//
//  DetailViewController.swift
//  idea
//
//  Created by 선민재 on 2022/12/29.
//

import UIKit
import MSGLayout
import Then
import Foundation

class DetailViewController: BaseViewController<DetailViewModel> {

    override func viewDidLoad() {
        getDetail()
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = ""
        configureVC()
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
    
    let positionText = UILabel().then {
        $0.font = UIFont.SCFont(size: 14,family: .Regular)
        $0.textColor = .black
    }
    
    let countText = UILabel().then {
        $0.font = UIFont.SCFont(size: 14,family: .Regular)
        $0.textColor = .black
    }
    
    let writerText = UILabel().then {
        $0.text = "개설자:"
        $0.font = UIFont.SCFont(size: 14,family: .Regular)
        $0.textColor = .black
    }
    
    let writer = UILabel().then {
        $0.font = UIFont.SCFont(size: 14,family: .Regular)
        $0.textColor = UIColor(red: 0, green: 117/255, blue: 1, alpha: 1)
    }
    
    let listTableView = UITableView().then {
        $0.register(DetailTableViewCell.self, forCellReuseIdentifier: "DetailTableViewCell")
        $0.separatorStyle = .none
        $0.rowHeight = 75
        $0.layer.cornerRadius = 8
    }
    
    lazy var joinBtn = UIButton().then {
        $0.setTitle("신청하기", for: .normal)
        $0.titleLabel?.font = UIFont.SCFont(size: 14, family: .Bold)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.backgroundColor = .Main
        $0.layer.cornerRadius = 4
        $0.addTarget(self, action: #selector(joinBtnDidTap), for: .touchUpInside)
    }
    
    @objc func joinBtnDidTap() {
        if BaseVC.decodedDetailData?.isStatus == false {
            join()
        }
        else if BaseVC.decodedDetailData?.isStatus == true {
            delete()
        }
    }
    
    func configureVC() {
        view.backgroundColor = .white
        listTableView.dataSource = self
        listTableView.delegate = self
    }
    
    func getDetailAPI() {
        titleText.text = BaseVC.decodedDetailData?.title
        contentText.text = BaseVC.decodedDetailData?.content
        categoryText.text = "전공: \(BaseVC.decodedDetailData?.category ?? "")"
        dateText.text = "날짜: \(BaseVC.decodedDetailData?.date ?? "")"
        switch BaseVC.decodedDetailData?.studyType {
        case "컨퍼런스":
            positionText.text = "장소: 시청각실"
            break
        case "스터디":
            positionText.text = "장소: 홈베이스"
            break
        default:
            positionText.text = "장소: 에러"
        }
        countText.text = "현재인원: \(BaseVC.decodedDetailData?.count.count ?? 0)/\(BaseVC.decodedDetailData?.count.maxCount ?? 0)"
        writer.text = "\(BaseVC.decodedDetailData?.writer.stuNum ?? 0)\(BaseVC.decodedDetailData?.writer.name ?? "")"
        if BaseVC.decodedDetailData?.isStatus == true {
            joinBtn.setTitle("취소하기", for: .normal)
            joinBtn.backgroundColor = UIColor(red: 248/255, green: 112/255, blue: 112/255, alpha: 1)
        }
        if BaseVC.decodedDetailData?.isMine == true {
            joinBtn.setTitle("개설자", for: .normal)
            joinBtn.backgroundColor = UIColor(red: 168/255, green: 168/255, blue: 168/255, alpha: 1)
        }
    }
    
    override func addView() {
        [titleText,contentText,categoryText,dateText,countText,writerText,writer,listTableView,joinBtn].forEach {
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
            countText.layout
                .top(.to(dateText).bottom, .equal(13))
                .leading(.to(view).leading, .equal(26))
            writerText.layout
                .top(.to(countText).bottom, .equal(13))
                .leading(.to(view).leading, .equal(26))
            writer.layout
                .top(.to(countText).bottom ,.equal(13))
                .leading(.to(writerText).trailing, .equal(10))
            listTableView.layout
                .top(.to(writer).bottom, .equal(20))
                .bottom(.to(view).bottom, .equal((bounds.height) / 4.86))
                .leading(.to(view).leading, .equal(27))
                .trailing(.to(view).trailing, .equal(-27))
                .centerX(.toSuperview())
            joinBtn.layout
                .bottom(.to(view).bottom,.equal(-74))
                .centerX(.toSuperview())
                .leading(.to(view).leading, .equal(27))
                .trailing(.to(view).trailing, .equal(-27))
                .height(47)
        }
    }

}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BaseVC.decodedDetailData?.list.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as? DetailTableViewCell else { return UITableViewCell()}
        cell.listUser.text = "\(BaseVC.decodedDetailData?.list[indexPath.row].stuNum ?? 0)\(BaseVC.decodedDetailData?.list[indexPath.row].name ?? "")"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        viewModel.cellDidSelect(index: indexPath.row)
    }
}
