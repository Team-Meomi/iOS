//
//  LoginViewModel.swift
//  idea
//
//  Created by 선민재 on 2022/12/15.
//

import UIKit
import RxSwift
import RxCocoa

final class LoginViewModel: BaseViewModel {
    var coordinator: MainCoordinator
    
    init(coordinator: MainCoordinator){
        self.coordinator = coordinator
    }
    
    func pushMainVC() {
        coordinator.pushMainVC()
    }
    func pushSignUpVC() {
        coordinator.pushSignUpVC()
    }
    
}

extension LoginViewModel: ViewModelType{

    struct Input {
    }

    struct Output {
        
    }
}
