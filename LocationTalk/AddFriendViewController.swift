//
//  AddFriendViewController.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2016/12/27.
//  Copyright © 2016年 鄭宇翔. All rights reserved.
//

import UIKit
import Firebase

class AddFriendViewController: UIViewController, UITextFieldDelegate, AccountProtocol, AddFriendDelegate {
    
    @IBOutlet weak var emailSearchText: UITextField!
    @IBOutlet weak var resultEmailLabel: UILabel!
    @IBOutlet weak var resultNameLabel: UILabel!
    @IBOutlet weak var addFriendButton: UIButton!
    
    var friendNode: String?
    var addFriend: AddFriend!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.

        emailSearchText.delegate = self
        addFriend = AddFriend.init()
        addFriend.delagate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let searchTarget = emailSearchText.text {
            addFriend.searchFriends(searchTarget)
            friendNode = self.emailToNode(searchTarget)
        }
    
        return true
    }
    
    @IBAction func pressAddFriend(_ sender: Any) {
        
//        let friendInfoForMe = FriendInfo.init(resultEmailLabel.text!, username: resultNameLabel.text!, state: .invite)
//        let selfNode = self.emailToNode((FIRAuth.auth()?.currentUser?.email)!)
//        ref.child("\(selfNode)/friend/\(friendNode!)").setValue(friendInfoForMe.context())
//        
//        let myState = MyState.sharedInstance
//        let friendInfoForYou = FriendInfo.init(myState.email!, username: myState.username!, state: .beInvited)
//        ref.child("\(friendNode!)/friend/\(selfNode)").setValue(friendInfoForYou.context())
        
    }

    @IBAction func signOut(_ sender: Any) {
        do {
            try FIRAuth.auth()?.signOut()
            let myState = MyState.sharedInstance
            myState.signedIn = false
        } catch  {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
    
    //MARK:- AddFriendDelegate
    func didSearchFriend(email: String, username: String) {
        self.resultNameLabel.text = username
        self.resultEmailLabel.text = email
        self.addFriendButton.isHidden = false
    }
    
    func notSearchFriend() {
        self.resultEmailLabel.text = "Not Found"
        self.resultNameLabel.text = "Not Found"
        self.addFriendButton.isHidden = true
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
