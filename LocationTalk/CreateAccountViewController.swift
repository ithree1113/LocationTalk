//
//  CreateAccountViewController.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2016/12/27.
//  Copyright © 2016年 鄭宇翔. All rights reserved.
//

import UIKit
import Firebase

class CreateAccountViewController: UIViewController, AccountProtocol {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var ref: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        ref = FIRDatabase.database().reference()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressCreateAccount(_ sender: UIButton) {
        if let email = emailField.text, let password = passwordField.text, let username = usernameField.text {
            if (email != "" && password != "" && username != "") {
                
                FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                    if let error = error {
                        print(error.localizedDescription)
                        self.errorAlert(title: Constants.ErrorAlert.alertTitle, message: error.localizedDescription, onViewController: self)
                        return
                    }
                    self.setDisplayName(user!, displayname: username)
                    let userInfo = [Constants.FirebaseKey.email: email, Constants.FirebaseKey.password: password, Constants.FirebaseKey.username: username]
                    
                    let node = self.emailToNode(email)
                    
                    self.ref.child(node).setValue(userInfo)
                    
                    self.signIn(user, withSegue: Constants.Segue.newUserLogin, onViewController: self)
                    
                })
            } else {
                self.errorAlert(title: Constants.ErrorAlert.alertTitle, message: Constants.ErrorAlert.loginMissingMessage, onViewController: self)
            }
        }
    }
    
    
    func setDisplayName(_ user: FIRUser, displayname: String) {
        let changeRequest = user.profileChangeRequest()
        changeRequest.displayName = displayname
        //        print("\(changeRequest.displayName!)")
        changeRequest.commitChanges(){ (error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            //            self.signedIn(FIRAuth.auth()?.currentUser)
        }
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
