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

enum userSelected {
    case opened
    case joined
}

final class ProfileViewModel: BaseViewModel {
    var coordinator: MainCoordinator
    
    init(coordinator: MainCoordinator){
        self.coordinator = coordinator
    }
    
    func pushLogin() {
        coordinator.pushLoginVC()
    }
    
    func pushIntro() {
        coordinator.pushIntroVC()
    }
    
    struct Input {
        var viewWillAppear: Observable<Void>
        var selectButtonDidTap: Observable<userSelected>
    }

    struct Output {
        var writtenList: Observable<[SinglePostListResponse]>
        var joinedList: Observable<[SinglePostListResponse]>
        var profile: Observable<GetMyDataResponse>
        var currentSelected: Observable<userSelected>
    }
    
    func transform(_ input: Input) -> Output {
        let provider = MoyaProvider<ProfileServices>(plugins: [NetworkLoggerPlugin()])
        
        let writtenRelay = BehaviorRelay<[SinglePostListResponse]>(value: [])
        let profileRelay = PublishRelay<GetMyDataResponse>()
        let joinedRelay = BehaviorRelay<[SinglePostListResponse]>(value: [])
        let currentSelected = BehaviorRelay(value: userSelected.opened)
        
        input.viewWillAppear
            .flatMap {
                Observable<[SinglePostListResponse]>.create { observer in
                    provider.request(.userWritten(id: BaseVC.decodedMyData?.id ?? 1, authorization: BaseVC.userData!.accessToken)) { result in
                        switch result {
                        case let .success(res):
                            let data = try? JSONDecoder().decode([SinglePostListResponse].self, from: res.data)
                            print("WRITTEN", data)
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
        
        input.viewWillAppear
            .flatMap {
                Observable<[SinglePostListResponse]>.create { observer in
                    provider.request(.userJoined(id: BaseVC.decodedMyData?.id ?? 1, authorization: BaseVC.userData!.accessToken)) { result in
                        switch result {
                        case let .success(res):
                            let data = try? JSONDecoder().decode([SinglePostListResponse].self, from: res.data)
                            observer.onNext(data ?? [])
                        case let .failure(err):
                            observer.onError(err)
                        }
                    }
                    return Disposables.create()
                }
            }
            .bind(to: joinedRelay)
            .disposed(by: disposeBag)
        
        input.selectButtonDidTap
            .bind(to: currentSelected)
            .disposed(by: disposeBag)
        
        return Output(
            writtenList: writtenRelay.asObservable(),
            joinedList: joinedRelay.asObservable(),
            profile: profileRelay.asObservable(),
            currentSelected: currentSelected.asObservable()
        )
    }

}


