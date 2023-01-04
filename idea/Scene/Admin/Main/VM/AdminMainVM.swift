//
//  AdminMainVM.swift
//  idea
//
//  Created by 선민재 on 2023/01/02.
//

import UIKit
import RxSwift
import RxCocoa
import Moya

enum adminSelected {
    case con
    case study
}

final class AdminMainVM: BaseViewModel {
    var coordinator: MainCoordinator
    
    init(coordinator: MainCoordinator){
        self.coordinator = coordinator
    }
    
    func pushIntro() {
        coordinator.pushIntroVC()
    }
    
    func pushMain() {
        coordinator.pushMainVC()
    }
    
    struct Input {
        var viewWillAppear: Observable<Void>
        var selectButtonDidTap: Observable<adminSelected>
    }

    struct Output {
        var conList: Observable<[SingleGetResponse]>
        var studyList: Observable<[SingleGetResponse]>
        var currentSelected: Observable<adminSelected>
    }
    
    func transform(_ input: Input) -> Output {
        let provider = MoyaProvider<AdminMainServices>(plugins: [NetworkLoggerPlugin()])
        
        let conRelay = BehaviorRelay<[SingleGetResponse]>(value: [])
        let studyRelay = BehaviorRelay<[SingleGetResponse]>(value: [])
        let currentSelected = BehaviorRelay(value: adminSelected.con)
        
        input.viewWillAppear
            .flatMap {
                Observable<[SingleGetResponse]>.create { observer in
                    provider.request(.checkCon(authorization: BaseVC.userData!.accessToken)) { result in
                        switch result {
                        case let .success(res):
                            print(
                                String(data: res.data, encoding: .utf8)
                            )
                            let data = try? JSONDecoder().decode(SingleGetModel.self, from: res.data)
                            
                            observer.onNext(data?.list ?? [])
                        case let .failure(err):
                            observer.onError(err)
                        }
                    }
                    return Disposables.create()
                }
            }
            .bind(to: conRelay)
            .disposed(by: disposeBag)
        
        input.viewWillAppear
            .flatMap {
                Observable<[SingleGetResponse]>.create { observer in
                    provider.request(.checkStu(authorization: BaseVC.userData!.accessToken)) { result in
                        switch result {
                        case let .success(res):
                            print(
                                String(data: res.data, encoding: .utf8)
                            )
                            let data = try? JSONDecoder().decode(SingleGetModel.self, from: res.data)
                            observer.onNext(data?.list ?? [])
                        case let .failure(err):
                            observer.onError(err)
                        }
                    }
                    return Disposables.create()
                }
            }
            .bind(to: studyRelay)
            .disposed(by: disposeBag)
        
        input.selectButtonDidTap
            .bind(to: currentSelected)
            .disposed(by: disposeBag)
        
        return Output(
            conList: conRelay.asObservable(),
            studyList: studyRelay.asObservable(),
            currentSelected: currentSelected.asObservable()
        )
    }

}
