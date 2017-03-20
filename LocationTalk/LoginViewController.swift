//
//  LoginViewController.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2016/12/27.
//  Copyright © 2016年 鄭宇翔. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, AccountProtocol, AuthDelegate, LoginViewDelegate {
    
    @IBOutlet weak var loginView: LoginView! {
        didSet {
            loginView.delegate = self
        }
    }
    
    var auth: AuthObject! {
        didSet {
            auth.delagate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            try auth = Database().auth()
            if let user = auth.currentUser() {
                MyProfile.shared.signedIn(email: user.email, username: user.username)
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: Constants.Segue.loginToMain, sender: nil)
                }
                
            }
        } catch  {
            fatalError("\(error)")
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

// MARK: - LoginViewDelegate
extension LoginViewController {
    func loginViewLoginWith(email: String?, password: String?) {
        if let email = email, let password = password {
            if (email != "" && password != "") {
                auth.login(email: email, password: password)
            } else {
                auth.inputErrorAlert()
            }
        }
    }
    
    func loginViewSignUpWith(email: String?, password: String?) {
        performSegue(withIdentifier: Constants.Segue.loginToSignUp, sender: nil)
    }
}

// MARK: - AuthDelegate
extension LoginViewController {
    func authDidLogin(error: Error?) {
        if let error = error {
            self.errorAlert(title: Constants.ErrorAlert.alertTitle, message: error.localizedDescription, onViewController: self)
        } else {
            MyProfile.shared.signedIn(email: loginView.emailInput.text!, username: auth.currentUser()!.username)
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: Constants.Segue.loginToMain, sender: nil)
            }
        }
    }
}
