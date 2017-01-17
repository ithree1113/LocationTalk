//
//  LoginViewController.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2016/12/27.
//  Copyright © 2016年 鄭宇翔. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, AccountProtocol, FirebaseAuthDelegate, LoginViewDelegate {
    
    @IBOutlet weak var loginView: LoginView! {
        didSet {
            loginView.delegate = self
        }
    }
    var firebaseAuth: FirebaseAuth! {
        didSet {
            firebaseAuth.delagate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firebaseAuth = FirebaseAuth.init()
        if let user = firebaseAuth.currentUser() {
            MyState.sharedInstance.signedIn(email: user.email!, username: user.displayName!)
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: Constants.Segue.loginToMain, sender: nil)
            }
            
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
                firebaseAuth.login(email: email, password: password)
            } else {
                firebaseAuth.inputErrorAlert()
            }
        }
    }
    
    func loginViewSignUpWith(email: String?, password: String?) {
        performSegue(withIdentifier: Constants.Segue.loginToSignUp, sender: nil)
    }
}

// MARK: - FirebaseAuthDelegate
extension LoginViewController {
    func firebaseAuthDidLogin(error: Error?) {
        if let error = error {
            self.errorAlert(title: Constants.ErrorAlert.alertTitle, message: error.localizedDescription, onViewController: self)
        } else {
            MyState.sharedInstance.signedIn(email: loginView.emailInput.text! , username: firebaseAuth.currentUser()!.displayName!)
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: Constants.Segue.loginToMain, sender: nil)
            }
        }
    }
}
