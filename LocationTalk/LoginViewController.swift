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
    
    @IBOutlet weak var loginView: LoginView!
    var auth: Authentication!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loginView.delegate = self
        auth = Authentication.init()
        auth.delagate = self
        
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
    func loginSuccess(_ user: FIRUser!) {
        auth.signIn(user, segue: Constants.Segue.loginToMain)
    }
    
    func loginFail(_ error: Error) {
        self.errorAlert(title: Constants.ErrorAlert.alertTitle, message: error.localizedDescription, onViewController: self)
    }
}
