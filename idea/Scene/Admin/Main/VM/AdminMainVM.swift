//
//  AdminMainVM.swift
//  idea
//
//  Created by 선민재 on 2023/01/02.
//

import UIKit

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

}

extension DetailViewModel: ViewModelType{

    struct Input {
        
    }

    struct Output {
        
    }
}
