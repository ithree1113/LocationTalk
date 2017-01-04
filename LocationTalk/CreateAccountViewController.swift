//
//  CreateAccountViewController.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2016/12/27.
//  Copyright © 2016年 鄭宇翔. All rights reserved.
//

import UIKit
import Firebase

class CreateAccountViewController: UIViewController, AccountProtocol, AuthenticationProtocol {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var auth: Authentication!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        auth = Authentication.init()
        auth.delagate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print("CreateAccountViewController deinit")
    }
    
    @IBAction func pressCreateAccount(_ sender: UIButton) {
        if let email = emailField.text, let password = passwordField.text, let username = usernameField.text {
            if (email != "" && password != "" && username != "") {
                auth.createAccount(email: email, password: password, username: username)
            } else {
                auth.inputErrorAlert()
            }
        }
    }
    // MARK: - AuthenticationProtocol
    func loginSuccess(_ user: FIRUser!) {
        auth.signIn(user, segue: Constants.Segue.newUserLogin)
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
