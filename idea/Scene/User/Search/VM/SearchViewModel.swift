//
//  SearchViewModel.swift
//  idea
//
//  Created by 선민재 on 2022/12/27.
//

import UIKit
import RxCocoa
import RxSwift
import Moya

final class SearchViewModel: BaseViewModel {
    var coordinator: MainCoordinator
    
    init(coordinator: MainCoordinator){
        self.coordinator = coordinator
    }
    
    struct Input {
        var searchBtnDidTap: Observable<Void>
        var conferenceCellDidselect: Observable<Int>
    }

    struct Output {
        var search: Observable<[SearchResponse]>
    }

    func transform(_ input: Input) -> Output {
        let provider = MoyaProvider<MainServices>(plugins: [NetworkLoggerPlugin()])

        let searchRelay = BehaviorRelay<[SearchResponse]>(value: [])

        let param = SearchRequest.init(BaseVC.userData!.accessToken, BaseVC.searchText, BaseVC.searchMajor)

        input.searchBtnDidTap
            .flatMap {
                Observable<[SearchResponse]>.create { observer in
                    provider.request(.search(param: param, authorization: BaseVC.userData!.accessToken)) { result in
                        switch result {
                        case let .success(res):
                            let data = try? JSONDecoder().decode([SearchResponse].self, from: res.data)
                            observer.onNext(data ?? [])

                        case let .failure(err):
                            observer.onError(err)
                        }
                    }
                    return Disposables.create()
                }
            }
            .bind(to: searchRelay)
            .disposed(by: disposeBag)

        input.conferenceCellDidselect
            .bind(with: self) { owner, id in
                owner.coordinator.pushDetailVC(id: id)
            }
            .disposed(by: disposeBag)


        return Output(
            search: searchRelay.asObservable()
        )
    }

}
