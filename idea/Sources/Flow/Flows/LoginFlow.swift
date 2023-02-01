//
//  LoginFlow.swift
//  idea
//
//  Created by 선민재 on 2023/02/01.
//
import RxFlow
import UIKit

class LoginFlow: Flow {

    var root: Presentable {
        return self.rootViewController
    }

    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        return viewController
    }()

    init() {}

    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? SCStep else { return .none }
        switch step {
        case .loginIsRequired:
            return self.coordinateToLogin()
        case .signInIsRequired:
            return self.navigateToSignIn()
        case .homeIsRequired:
            return self.navigateToHome()
        case .signUpIsRequired:
            return self.navigateToSignUp()
        default:
            return .none
        }
    }
    
    private func coordinateToLogin() -> FlowContributors {
        let vm = IntroViewModel()
        let vc = IntroViewController(vm)
        self.rootViewController.setViewControllers([vc], animated: false)
        return .one(flowContributor: .contribute(withNext: vc))
    }
    
    private func navigateToSignIn() -> FlowContributors {
        let vm = LoginViewModel()
        let vc = LoginViewController(vm)
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNext: vc))
    }
    private func navigateToSignUp() -> FlowContributors {
        let vm = SignUpViewModel()
        let vc = SignUpViewController(vm)
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNext: vc))
    }
    private func navigateToHome() -> FlowContributors {
        let vm = MainViewModel()
        let vc = MainViewController(vm)
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNext: vc))
    }
}
