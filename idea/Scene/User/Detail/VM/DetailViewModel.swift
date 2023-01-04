//
//  DetailViewModel.swift
//  idea
//
//  Created by 선민재 on 2022/12/29.
//

import UIKit
import RxCocoa
import RxSwift
import Moya

final class DetailViewModel: BaseViewModel {
    var coordinator: MainCoordinator
    let id: Int
    
    init(id: Int, coordinator: MainCoordinator){
        self.id = id
        self.coordinator = coordinator
    }
    
    func pushMain() {
        coordinator.pushMainVC()
    }
    
    func pushIntro() {
        coordinator.pushIntroVC()
    }
    
    struct Input {
        var viewWillAppear: Observable<Void>
    }
    
    struct Output {
        var list: Observable<[GetDetailResponse.SingleApplier]>
    }
    
    func transform(_ input: Input) -> Output {
        let provider = MoyaProvider<DetailServices>(plugins: [NetworkLoggerPlugin()])
        let listRelay = PublishRelay<[GetDetailResponse.SingleApplier]>()
        
        input.viewWillAppear
            .flatMap {
                Observable<[GetDetailResponse.SingleApplier]>.create { observer in
                    provider.request(.getDetail(id: self.id, authorization: BaseVC.userData?.accessToken ?? "")) { result in
                        switch result {
                        case let .success(res):
                            guard let data = try? JSONDecoder().decode([GetDetailResponse.SingleApplier].self, from: res.data) else {
                                observer.onError(CustomError.underlying)
                                return
            }
                            observer.onNext(data)
                            
                        case let .failure(err):
                            observer.onError(err)
                        }
                    }
                    return Disposables.create()
                }
            }
            .bind(to: listRelay)
            .disposed(by: disposeBag)

        return Output (
        list: listRelay.asObservable()
        )
    }
}
