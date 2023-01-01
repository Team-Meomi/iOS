//
//  SignUpViewModel.swift
//  idea
//
//  Created by 선민재 on 2022/12/15.
//

import UIKit
import RxSwift
import RxCocoa
import Moya

final class SignUpViewModel: BaseViewModel {
    var coordinator: MainCoordinator
    
    init(coordinator: MainCoordinator){
        self.coordinator = coordinator
    }
    
    func pushLoginVC() {
        coordinator.pushLoginVC()
    }
    
    func pushIntroVC() {
        coordinator.pushIntroVC()
    }
    
}

extension SignUpViewModel: ViewModelType{

    struct Input {
        
    }

    struct Output {
        
    }
}
