//
//  DetailViewModel.swift
//  idea
//
//  Created by 선민재 on 2022/12/29.
//

import UIKit

final class DetailViewModel: BaseViewModel {
    var coordinator: MainCoordinator
    
    init(coordinator: MainCoordinator){
        self.coordinator = coordinator
    }

}

extension DetailViewModel: ViewModelType{

    struct Input {
        
    }

    struct Output {
        
    }
}
