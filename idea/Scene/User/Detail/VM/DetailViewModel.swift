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
    
    struct Input {
        var viewWillAppear: Observable<Void>
    }
    
    struct Output {
        var title: Observable<GetDetailResponse>
        var content: Observable<GetDetailResponse>
        var category: Observable<GetDetailResponse>
        var date: Observable<GetDetailResponse>
        var count: Observable<GetDetailResponse>
        var writer: Observable<GetDetailResponse>
        var list: Observable<GetDetailResponse>
    }
    
    func transform(_ input: Input) -> Output {
        let provider = MoyaProvider<DetailServices>(plugins: [NetworkLoggerPlugin()])
        
        let titleRelay = PublishRelay<GetDetailResponse>()
        let contentRelay = PublishRelay<GetDetailResponse>()
        let categoryRelay = PublishRelay<GetDetailResponse>()
        let dateRelay = PublishRelay<GetDetailResponse>()
        let countRelay = PublishRelay<GetDetailResponse>()
        let writerRelay = PublishRelay<GetDetailResponse>()
        let listRelay = PublishRelay<GetDetailResponse>()
        
        input.viewWillAppear
            .flatMap {
                Observable<GetDetailResponse>.create { observer in
                    provider.request(.getDetail(id: self.id, authorization: BaseVC.userData?.accessToken ?? "")) { result in
                        switch result {
                        case let .success(res):
                            guard let data = try? JSONDecoder().decode(GetDetailResponse.self, from: res.data) else {
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
            .bind(to: titleRelay,contentRelay,categoryRelay,dateRelay,countRelay,writerRelay,listRelay)
            .disposed(by: disposeBag)

        return Output (
        title: titleRelay.asObservable(),
        content: countRelay.asObservable(),
        category: categoryRelay.asObservable(),
        date: dateRelay.asObservable(),
        count: countRelay.asObservable(),
        writer: writerRelay.asObservable(),
        list: listRelay.asObservable()
        )
    }
}
