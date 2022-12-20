//
//  CreateStuViewModel.swift
//  idea
//
//  Created by 선민재 on 2022/12/20.
//

import UIKit
import RxCocoa
import RxSwift

final class CreateStuViewModel: BaseViewModel {
    var coordinator: MainCoordinator
    
    init(coordinator: MainCoordinator){
        self.coordinator = coordinator
    }

}

extension CreateStuViewModel: ViewModelType{

    struct Input {
        
    }

    struct Output {
        
    }
}
