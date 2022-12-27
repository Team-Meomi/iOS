//
//  SearchViewModel.swift
//  idea
//
//  Created by 선민재 on 2022/12/27.
//

import UIKit
import RxCocoa
import RxSwift

final class SearchViewModel: BaseViewModel {
    var coordinator: MainCoordinator
    
    init(coordinator: MainCoordinator){
        self.coordinator = coordinator
    }

}

extension SearchViewModel: ViewModelType{

    struct Input {
        
    }

    struct Output {
        
    }
}
