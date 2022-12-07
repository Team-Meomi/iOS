//
//  Coordinator.swift
//  idea
//
//  Created by 선민재 on 2022/12/07.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
