//
//  AddFriendViewController.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2016/12/27.
//  Copyright © 2016年 鄭宇翔. All rights reserved.
//

import UIKit

class AddFriendByEmailViewController: UIViewController, UITextFieldDelegate, AccountProtocol, FirebaseFriendDelegate {
    
    @IBOutlet weak var emailSearchText: UITextField!
    @IBOutlet weak var resultEmailLabel: UILabel!
    @IBOutlet weak var resultNameLabel: UILabel!
    @IBOutlet weak var addFriendButton: UIButton!

    var firebaseFriend: FirebaseFriend! {
        didSet {
            firebaseFriend.delagate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailSearchText.delegate = self
        firebaseFriend = FirebaseFriend.init()
        
        self.addFriendButton.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print("AddFriendByEmailViewController deinit")
    }
    
    @IBAction func addFriendBtnPressed(_ sender: Any) {
        firebaseFriend.checkRelationshipBy(email: resultEmailLabel.text!)
    }

    @IBAction func signOut(_ sender: Any) {
        FirebaseAuth.init().signOut()
    }
}

// MARK: - UITextFieldDelegate
extension AddFriendByEmailViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let searchTarget = emailSearchText.text {
            firebaseFriend.search(email: searchTarget)
        }
        return true
    }
}

// MARK: - FirebaseFriendDelegate
extension AddFriendByEmailViewController {
    
    func firebaseFriendDidSearch(email: String?, username: String?) {
        if let email = email, let username = username {
            self.resultNameLabel.text = username
            self.resultEmailLabel.text = email
            if email != MyProfile.shared.email {
                self.addFriendButton.isHidden = false
            }
        } else {
            self.resultEmailLabel.text = "Not Found"
            self.resultNameLabel.text = "Not Found"
            self.addFriendButton.isHidden = true
        }
    }
    
    func firebaseFriendDidCheckRelationship(result: FriendState) {
        if result == .none {
            firebaseFriend.invite(resultEmailLabel.text!, username: resultNameLabel.text!)
        } else {
            self.errorAlert(title: Constants.ErrorAlert.alertTitle, message: "You are already friends, or waiting to accept the invitation.", onViewController: self)
        }
    }
}
