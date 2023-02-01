//
//  S&CStep.swift
//  idea
//
//  Created by 선민재 on 2023/02/01.
//

import RxFlow

enum SCStep {
    // Mark: Login
    case loginIsRequired
    
    // Mark: SignUp
    case signUpIsRequired
    
    // Mark: Home
    case homeIsRequired
    
    // Mark: SignIn
    case signInIsRequired
}
