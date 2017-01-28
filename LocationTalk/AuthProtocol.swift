//
//  AuthProtocol.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2017/1/28.
//  Copyright © 2017年 鄭宇翔. All rights reserved.
//

import Foundation

protocol AuthDelegate: class {
    func authDidLogin(error: Error?)
    func authDidSignUp(error: Error?)
}

protocol AuthProtocol {
    
    weak var delagate: AuthDelegate? {get set}
    
    func currentUser() -> MyUser?
    func login(email: String, password: String)
    func signUp(email: String, password: String, username: String)
    func inputErrorAlert()
}

extension AuthDelegate {
    func authDidLogin(error: Error?) {
    }
    func authDidSignUp(error: Error?) {
    }
}
