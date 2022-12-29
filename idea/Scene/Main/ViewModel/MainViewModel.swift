//
//  MainViewModel.swift
//  idea
//
//  Created by 선민재 on 2022/12/23.
//

import UIKit
import RxCocoa
import RxSwift
import Moya

final class MainViewModel: BaseViewModel {
    var coordinator: MainCoordinator
    
    init(coordinator: MainCoordinator){
        self.coordinator = coordinator
    }
    
    func pushCreateCon() {
        coordinator.pushCreateConVC()
    }
    
    func pushCreateStu() {
        coordinator.pushCreateStuVC()
    }
    
    func pushSearch() {
        coordinator.pushSearchVC()
    }
    
    func pushProfile() {
        coordinator.pushProfileVC()
    }
    
    func pushLogin() {
        coordinator.pushLoginVC()
    }
    
    struct Input {
        var viewWillAppear: Observable<Void>
    }

    struct Output {
        var list: Observable<[ListResponse]>
    }
    
    func transform(_ input: Input) -> Output {
        let provider = MoyaProvider<MainServices>(plugins: [NetworkLoggerPlugin()])
        
        let listRelay = BehaviorRelay<[ListResponse]>(value: [])
        
        input.viewWillAppear
            .flatMap {
                Observable<[ListResponse]>.create { observer in
                    provider.request(.getList(authorization: BaseVC.userData!.accessToken)) { result in
                        switch result {
                        case let .success(res):
                            let data = try? JSONDecoder().decode([ListResponse].self, from: res.data)
                            print(data)
                            observer.onNext(data ?? [])

                        case let .failure(err):
                            observer.onError(err)
                        }
                    }
                    return Disposables.create()
                }
            }
            .bind(to: listRelay)
            .disposed(by: disposeBag)
        
        return Output(
            list: listRelay.asObservable()
        )
    }

}

extension MainViewModel: ViewModelType{

    
}
