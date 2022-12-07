//
//  MainCoordinator.swift
//  idea
//
//  Created by 선민재 on 2022/12/07.
//

import UIKit
import RxCocoa
import RxSwift

class MainCoordinator:Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    let window: UIWindow
    
    
    init(navigationController: UINavigationController, window: UIWindow) {
        self.navigationController = navigationController
        self.window = window
        window.rootViewController = navigationController
    }
    
    func start() {
        let introVM = IntroViewModel(coordinator: self)
        let introVC = IntroViewController(introVM)
        navigationController.setViewControllers([introVC], animated: true)
    }
}
