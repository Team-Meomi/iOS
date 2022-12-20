//
//  MainViewModel.swift
//  idea
//
//  Created by 선민재 on 2022/12/16.
//

import UIKit
import RxCocoa
import RxSwift

final class MainViewModel: BaseViewModel {
    var coordinator: MainCoordinator
    
    init(coordinator: MainCoordinator){
        self.coordinator = coordinator
    }
    
    func pushCreateCon() {
        coordinator.pushCreateConVC()
    }
    
    func pushCreateStu() {
        coordinator.pushCreateStuVC()
    }

}

extension MainViewModel: ViewModelType{

    struct Input {
        
    }

    struct Output {
        
    }
}
