//
//  CreateAccountViewController.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2016/12/27.
//  Copyright © 2016年 鄭宇翔. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, AccountProtocol, FirebaseAuthDelegate, SignUpViewDelegate {
    
    @IBOutlet weak var signUpView: SignUpView! {
        didSet {
            signUpView.delegate = self
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print("SignUpViewController deinit")
    }
}

// MARK: - SignUpViewDelegate
extension SignUpViewController {
    func signUpViewDidSignUpWith(email: String?, password: String?, username: String?) {
        if let email = email, let password = password, let username = username {
            if (email != "" && password != "" && username != "") {
                firebaseAuth.signUp(email: email, password: password, username: username)
            } else {
                firebaseAuth.inputErrorAlert()
            }
        }
    }

    func signUpViewDidCancelWith(email: String?, password: String?, username: String?) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}

// MARK: - FirebaseAuthDelegate
extension SignUpViewController {
    func firebaseAuthDidSignUp(error: Error?) {
        if let error = error {
            self.errorAlert(title: Constants.ErrorAlert.alertTitle, message: error.localizedDescription, onViewController: self)
        } else {
            MyState.sharedInstance.signedIn(email: signUpView.emailInput.text! , username: signUpView.usernameInput.text!)
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: Constants.Segue.signupToMain, sender: nil)
            }
        }
    }
}
