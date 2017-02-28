//
//  AuthObject.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2017/2/24.
//  Copyright © 2017年 鄭宇翔. All rights reserved.
//

import Foundation

protocol AuthDelegate: class {
    func authDidLogin(error: Error?)
    func authDidSignUp(error: Error?)
}

class AuthObject: NSObject {
    
    weak var delagate: AuthDelegate?
    
    required override init() {
        
    }
    
    func currentUser() -> MyUser? {
        return nil
    }
    func login(email: String, password: String) {
        
    }
    func signUp(email: String, password: String, username: String) {
        
    }
    func inputErrorAlert() {
        
    }
}

extension AuthDelegate {
    func authDidLogin(error: Error?) {
    }
    func authDidSignUp(error: Error?) {
    }
}
