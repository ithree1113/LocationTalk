//
//  LoginViewController.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2016/12/27.
//  Copyright © 2016年 鄭宇翔. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, AccountProtocol, AuthenticationProtocol, LoginViewProtocol {
    
    @IBOutlet weak var loginView: LoginView! {
        didSet {
            loginView.delegate = self
        }
    }
    var auth: Authentication! = Authentication.init() {
        didSet {
            auth.delagate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let user = FIRAuth.auth()?.currentUser {
            auth.signIn(user, segue: Constants.Segue.loginToMain)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print("LoginViewController deinit")
    }
    
    @IBAction func unwindToLogin(segue: UIStoryboardSegue) {        
    }
}

// MARK: - LoginViewProtocol
extension LoginViewController {
    func didLoginButtonPressed(email: String?, password: String?) {
        if let email = email, let password = password {
            if (email != "" && password != "") {
                auth.login(email: email, password: password)
            } else {
                auth.inputErrorAlert()
            }
        }
    }
    
    func didSignUpButtonPressed(email: String?, password: String?) {
        performSegue(withIdentifier: Constants.Segue.loginToSignUp, sender: nil)
    }
}

// MARK: - AuthenticationProtocol
extension LoginViewController {
    func didLogin(user: FIRUser?, error: Error?) {
        if let error = error {
            self.errorAlert(title: Constants.ErrorAlert.alertTitle, message: error.localizedDescription, onViewController: self)
        } else {
            auth.signIn(user, segue: Constants.Segue.loginToMain)
        }
    }
}
