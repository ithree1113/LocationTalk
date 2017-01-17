//
//  Authentication.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2017/1/4.
//  Copyright © 2017年 鄭宇翔. All rights reserved.
//

import Foundation
import Firebase
protocol FirebaseAuthDelegate: class {
    func firebaseAuthDidLogin(error: Error?)
    func firebaseAuthDidSignUp(error: Error?)
}


class FirebaseAuth: AccountProtocol {
    
    weak var delagate: FirebaseAuthDelegate?
    var ref: FIRDatabaseReference!
    
    init() {
        self.ref = FIRDatabase.database().reference()
    }
    
    deinit {
        print("Authentication deinit")
    }
    
    func currentUser() -> FIRUser? {
        return FIRAuth.auth()?.currentUser
    }
    
    func login(email: String, password: String) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { [weak self] (user, error) in
            guard let strongSelf = self else {return}
            strongSelf.delagate?.firebaseAuthDidLogin(error: error)
        })
    }
    
    func signUp(email: String, password: String, username: String) {
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { [weak self] (user, error) in
            guard let strongSelf = self else {return}
            if error == nil {
                strongSelf.setDisplayName(user!, displayname: username)
                let userInfo = [Constants.FirebaseKey.email: email, Constants.FirebaseKey.password: password, Constants.FirebaseKey.username: username]
                let node = strongSelf.emailToNode(email)
                strongSelf.ref.child(node).setValue(userInfo)
            }
            strongSelf.delagate?.firebaseAuthDidSignUp(error: error)
        })
    }
    
    func setDisplayName(_ user: FIRUser, displayname: String) {
        let changeRequest = user.profileChangeRequest()
        changeRequest.displayName = displayname
        changeRequest.commitChanges(){ (error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
        }
    }
    
    func inputErrorAlert() {
        // Called upon signup error to let the user know signup didn't work.        
        let alert = UIAlertController(title: Constants.ErrorAlert.alertTitle, message: Constants.ErrorAlert.loginMissingMessage, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        if let vc = self.delagate as? UIViewController {
            vc.present(alert, animated: true, completion: nil)
        }
    }
}

extension FirebaseAuthDelegate {
    func firebaseAuthDidLogin(error: Error?) {
    }
    func firebaseAuthDidSignUp(error: Error?) {
    }
}
