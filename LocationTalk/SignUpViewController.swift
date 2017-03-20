//
//  CreateAccountViewController.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2016/12/27.
//  Copyright © 2016年 鄭宇翔. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, AccountProtocol, AuthDelegate, SignUpViewDelegate {
    
    @IBOutlet weak var signUpView: SignUpView! {
        didSet {
            signUpView.delegate = self
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
        } catch  {
            fatalError("\(error)")
        }
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
                auth.signUp(email: email, password: password, username: username)
            } else {
                auth.inputErrorAlert()
            }
        }
    }

    func signUpViewDidCancelWith(email: String?, password: String?, username: String?) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}

// MARK: - AuthDelegate
extension SignUpViewController {
    func authDidSignUp(error: Error?) {
        if let error = error {
            self.errorAlert(title: Constants.ErrorAlert.alertTitle, message: error.localizedDescription, onViewController: self)
        } else {
            MyProfile.shared.signedIn(email: signUpView.emailInput.text!, username: signUpView.usernameInput.text!)
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: Constants.Segue.signupToMain, sender: nil)
            }
        }
    }
}
