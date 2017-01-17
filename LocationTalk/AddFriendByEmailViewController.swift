//
//  AddFriendViewController.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2016/12/27.
//  Copyright © 2016年 鄭宇翔. All rights reserved.
//

import UIKit
import Firebase

class AddFriendByEmailViewController: UIViewController, UITextFieldDelegate, AccountProtocol, AddFriendDelegate {
    
    @IBOutlet weak var emailSearchText: UITextField!
    @IBOutlet weak var resultEmailLabel: UILabel!
    @IBOutlet weak var resultNameLabel: UILabel!
    @IBOutlet weak var addFriendButton: UIButton!
    
    var friendNode: String?
    var addFriend: AddFriend!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailSearchText.delegate = self
        addFriend = AddFriend.init()
        addFriend.delagate = self
        
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
        addFriend.check(resultEmailLabel.text!)
    }

    @IBAction func signOut(_ sender: Any) {
        do {
            try FIRAuth.auth()?.signOut()
            let myState = MyState.sharedInstance
//            myState.signedIn = false
            myState.signedOut()
        } catch  {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}

// MARK: - UITextFieldDelegate
extension AddFriendByEmailViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let searchTarget = emailSearchText.text {
            addFriend.searchFriends(searchTarget)
            friendNode = self.emailToNode(searchTarget)
        }
        return true
    }
}

// MARK: - AddFriendDelegate
extension AddFriendByEmailViewController {
    
    func didSearchFriend(email: String?, username: String?) {
        if let email = email, let username = username {
            self.resultNameLabel.text = username
            self.resultEmailLabel.text = email
            self.addFriendButton.isHidden = false
        } else {
            self.resultEmailLabel.text = "Not Found"
            self.resultNameLabel.text = "Not Found"
            self.addFriendButton.isHidden = true
        }
    }
    
    func didCheckThisEmail(result: FriendState) {
        if result == .none {
            addFriend.invite(resultEmailLabel.text!, username: resultNameLabel.text!)
        } else {
            self.errorAlert(title: Constants.ErrorAlert.alertTitle, message: "You are already friends, or waiting to accept the invitation.", onViewController: self)
        }
    }
}
