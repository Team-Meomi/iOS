//
//  DetailViewModel.swift
//  idea
//
//  Created by 선민재 on 2022/12/29.
//

import UIKit

final class DetailViewModel: BaseViewModel {
    var coordinator: MainCoordinator
    let id: Int
    
    init(id: Int, coordinator: MainCoordinator){
        self.id = id
        self.coordinator = coordinator
    }
    
    func pushIntro() {
        coordinator.pushIntroVC()
    }

}

extension DetailViewModel: ViewModelType{

    struct Input {
        
    }

    struct Output {
        
    }
}
