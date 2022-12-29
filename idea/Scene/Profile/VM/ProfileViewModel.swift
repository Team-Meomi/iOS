//
//  ProfileViewModel.swift
//  idea
//
//  Created by 선민재 on 2022/12/28.
//

import UIKit
import RxCocoa
import RxSwift
import Moya

enum CustomError: Error {
    case underlying
}

final class ProfileViewModel: BaseViewModel {
    var coordinator: MainCoordinator
    
    init(coordinator: MainCoordinator){
        self.coordinator = coordinator
    }
    
    func pushLogin() {
        coordinator.pushLoginVC()
    }
    struct Input {
        var viewWillAppear: Observable<Void>
    }

    struct Output {
        var list: Observable<[UserWrittenResponse]>
        var profile: Observable<GetMyDataResponse>
    }
    
    func transform(_ input: Input) -> Output {
        let provider = MoyaProvider<ProfileServices>(plugins: [NetworkLoggerPlugin()])
        
        let writtenRelay = BehaviorRelay<[UserWrittenResponse]>(value: [])
        let profileRelay = PublishRelay<GetMyDataResponse>()
        
        input.viewWillAppear
            .flatMap {
                Observable<[UserWrittenResponse]>.create { observer in
                    provider.request(.userWritten(id: BaseVC.decodedMyData?.id ?? 1, authorization: BaseVC.userData!.accessToken)) { result in
                        switch result {
                        case let .success(res):
                            let data = try? JSONDecoder().decode([UserWrittenResponse].self, from: res.data)
                            observer.onNext(data ?? [])

                        case let .failure(err):
                            
                            observer.onError(err)
                        }
                    }
                    return Disposables.create()
                }
            }
            .bind(to: writtenRelay)
            .disposed(by: disposeBag)
        
        input.viewWillAppear
            .flatMap {
                Observable<GetMyDataResponse>.create { observer in
                    provider.request(.getMyData(authorization: BaseVC.userData?.accessToken ?? "")) { result in
                        switch result {
                        case let .success(res):
                            guard let data = try? JSONDecoder().decode(GetMyDataResponse.self, from: res.data) else {
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
            .bind(to: profileRelay)
            .disposed(by: disposeBag)
        
        return Output(
            list: writtenRelay.asObservable(),
            profile: profileRelay.asObservable()
        )
    }

}


