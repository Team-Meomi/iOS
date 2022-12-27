//
//  ProfileViewModel.swift
//  idea
//
//  Created by 선민재 on 2022/12/28.
//

import UIKit
import RxCocoa
import RxSwift

final class ProfileViewModel: BaseViewModel {
    var coordinator: MainCoordinator
    
    init(coordinator: MainCoordinator){
        self.coordinator = coordinator
    }

}

extension ProfileViewModel: ViewModelType{

    struct Input {
        
    }

    struct Output {
        
    }
}
