//
//  IntroViewModel.swift
//  idea
//
//  Created by 선민재 on 2022/12/07.
//

import UIKit
import RxSwift
import RxCocoa

final class IntroViewModel: BaseViewModel {
    var coordinator: MainCoordinator
    
    init(coordinator: MainCoordinator){
        self.coordinator = coordinator
    }

    func transVC(input: Input) {
        input.loginButtonTap.subscribe(
        onNext: pushLoginVC
        ) .disposed(by: disposeBag)
        
        input.signUpButtonTap.subscribe(
        onNext: pushSignUpVC
        ) .disposed(by: disposeBag)
    }
    
    private func pushLoginVC() {
        coordinator.pushLoginVC()
    }
    private func pushSignUpVC() {
        coordinator.pushSignUpVC()
    }
    
}

extension IntroViewModel: ViewModelType{

    struct Input {
        let loginButtonTap: Observable<Void>
        let signUpButtonTap: Observable<Void>
    }

    struct Output {
        
    }
}
