//
//  AppFlow.swift
//  idea
//
//  Created by 선민재 on 2023/02/01.
//

import RxFlow
import UIKit
import RxSwift
import RxCocoa

struct AppStepper: Stepper {
    let steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()
    
    init() {}
    
    var initialStep: Step {
        return SCStep.loginIsRequired
    }
}

final class AppFlow: Flow {
    private var rootViewController = UINavigationController()
    
    var root: Presentable {
        return self.rootViewController
    }
    
    deinit{
        print("\(type(of: self)): \(#function)")
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? SCStep else {return .none}
        
        switch step {
        case .loginIsRequired:
            return coordinateToLogin()
        default:
            return .none
        }
    }
    
    private func coordinateToLogin() -> FlowContributors {
        let flow = LoginFlow()
        Flows.use(flow, when: .created) { (root) in
            self.rootViewController = root as! UINavigationController
        }
        return .one(
            flowContributor: .contribute(
                withNextPresentable: flow,
                withNextStepper: OneStepper(withSingleStep: SCStep.loginIsRequired)
        ))
    }
    
}

