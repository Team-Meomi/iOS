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
    
//    func start() {
//        let introVM = IntroViewModel()
//        let introVC = IntroViewController(introVM)
//        navigationController.setViewControllers([introVC], animated: true)
////        let mainVM = MainViewModel(coordinator: self)
////        let mainVC = MainViewController(mainVM)
////        navigationController.setViewControllers([mainVC], animated: true)
//    }
//
    func pushCreateConVC() {
        let conVM = CreateConViewModel(coordinator: self)
        let conVC = CreateConViewController(conVM)
        navigationController.pushViewController(conVC, animated: true)
    }
    
    func pushCreateStuVC() {
        let stuVM = CreateStuViewModel(coordinator: self)
        let stuVC = CreateStuViewController(stuVM)
        navigationController.pushViewController(stuVC, animated: true)
    }
    
    func pushSearchVC() {
        let searchVM = SearchViewModel(coordinator: self)
        let searchVC = SearchViewController(searchVM)
        navigationController.pushViewController(searchVC, animated: true)
    }
    
    func pushProfileVC() {
        let profileVM = ProfileViewModel(coordinator: self)
        let profileVC = ProfileViewController(profileVM)
        navigationController.pushViewController(profileVC, animated: true)
    }

    func pushDetailVC(id: Int) {
        let vm = DetailViewModel(id: id, coordinator: self)
        let vc = DetailViewController(vm)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func pushAdminVC() {
        let adminVm = AdminMainVM(coordinator: self)
        let adminVc = AdminMainVC(adminVm)
        navigationController.pushViewController(adminVc, animated: true)
    }
}
