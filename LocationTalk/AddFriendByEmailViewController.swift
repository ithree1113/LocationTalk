//
//  AddFriendViewController.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2016/12/27.
//  Copyright © 2016年 鄭宇翔. All rights reserved.
//

import UIKit

class AddFriendByEmailViewController: UIViewController, AccountProtocol, FriendshipDelegate, AddFriendByEmailViewDelegate {
    
    @IBOutlet weak var addFriendByEmailView: AddFriendByEmailView! {
        didSet {
            addFriendByEmailView.delegate = self
            addFriendByEmailView.addButton.isHidden = true
        }
    }

    var friendship: FriendshipProtocol! {
        didSet {
            friendship.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        friendship = Database().friendship()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print("AddFriendByEmailViewController deinit")
    }

    @IBAction func signOut(_ sender: Any) {
        FirebaseAuth.init().signOut()
    }
}

// MARK: - AddFriendByEmailViewDelegate
extension AddFriendByEmailViewController {
    func addFriendByEmailViewShouldReturn(_ textField: UITextField, email: String) {
        textField.resignFirstResponder()
        if !(email.isEmpty) {
            friendship.search(email)
        }
    }
    
    func addButtonDidPressed() {
        friendship.checkRelationshipBy(email: addFriendByEmailView.searchText.text!)
    }
}

// MARK: - FriendshipDelegate
extension AddFriendByEmailViewController {
    
    func friendshipDidSearch(email: String?, username: String?) {
        if let email = email, let username = username {
            addFriendByEmailView.usernameResultLabel.text = username
            if email != MyProfile.shared.email {
                addFriendByEmailView.addButton.isHidden = false
            }
        } else {
            addFriendByEmailView.usernameResultLabel.text = "Not Found"
            addFriendByEmailView.addButton.isHidden = true
        }
    }
    
    func friendshipDidCheckRelationship(result: FriendState) {
        if result == .none {
            friendship.invite(email: addFriendByEmailView.searchText.text!, username: addFriendByEmailView.usernameResultLabel.text!)
        } else {
            self.errorAlert(title: Constants.ErrorAlert.alertTitle, message: "You are already friends, or waiting to accept the invitation.", onViewController: self)
        }
    }
}
