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

    struct Input {
        
    }

    struct Output {
        
    }
    
}
