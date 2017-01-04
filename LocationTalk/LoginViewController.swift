//
//  LoginViewController.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2016/12/27.
//  Copyright © 2016年 鄭宇翔. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, AccountProtocol, AuthenticationProtocol {
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    var auth: Authentication!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        do {
//            try FIRAuth.auth()?.signOut()
//            let myState = MyState.sharedInstance
//            myState.signedIn = false
//        } catch  {
//            print("Error signing out: \(error.localizedDescription)")
//        }
        auth = Authentication.init()
        auth.delagate = self
        if let user = FIRAuth.auth()?.currentUser {
            self.signIn(user, withSegue: Constants.Segue.userLogin, onViewController: self)
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print("LoginViewController deinit")
    }
    
    @IBAction func pressLogin(_ sender: UIButton) {
        if let email = emailField.text, let password = passwordField.text {
            if (email != "" && password != "") {
                auth.login(email: email, password: password)
            }
        } else {
            auth.inputErrorAlert()
        }
    }
    
    @IBAction func unwindToLogin(segue: UIStoryboardSegue) {
        
    }
    
    // MARK: - AuthenticationProtocol
    func loginSuccess(_ user: FIRUser!) {
        auth.signIn(user, segue: Constants.Segue.userLogin)
    }
    
    func loginFail(_ error: Error) {
        self.errorAlert(title: Constants.ErrorAlert.alertTitle, message: error.localizedDescription, onViewController: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
