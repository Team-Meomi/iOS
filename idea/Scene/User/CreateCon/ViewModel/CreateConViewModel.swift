//
//  CreateConViewModel.swift
//  idea
//
//  Created by 선민재 on 2022/12/20.
//

import UIKit
import RxCocoa
import RxSwift

final class CreateConViewModel: BaseViewModel {
    var coordinator: MainCoordinator
    
    init(coordinator: MainCoordinator){
        self.coordinator = coordinator
    }
    func pushMainVC() {
        coordinator.pushMainVC()
    }
    func pushLogin() {
        coordinator.pushLoginVC()
    }

}

extension CreateConViewModel: ViewModelType{

    struct Input {
        
    }

    struct Output {
        
    }
}
