//
//  FirebaseFriend.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2017/1/19.
//  Copyright © 2017年 鄭宇翔. All rights reserved.
//

import Foundation
import Firebase


class FirebaseFriendship: FriendshipObject, AccountProtocol {

    fileprivate var _refHandle: FIRDatabaseHandle!
    fileprivate var _friendListHandle: FIRDatabaseHandle?
//    weak var delegate: FriendshipDelegate?
    
    var ref: FIRDatabaseReference!
    
    required init() {
        self.ref = FIRDatabase.database().reference()
    }
    
    deinit {
        print("FirebaseFriend deinit")
        if let _friendListHandle = _friendListHandle {
            let myNode = self.emailToNode(MyProfile.shared.email)
            ref.child("\(myNode)/friend").removeObserver(withHandle: _friendListHandle)
        }
    }
    
    
    // To get friend list
    override func getFriendListFrom(_ email: String) {
        
        let node = self.emailToNode(email)
        
        _friendListHandle = ref.child("\(node)/friend").observe(.value, with: { [weak self](snapshot) in
            guard let strongSelf = self else {return}
            if (snapshot.exists()) {
                let friends = snapshot.value as! Dictionary<String, Any>
                
                // To judge the relationship
                var friendArray: [FriendInfo] = []
                var beIvitedArray: [FriendInfo] = []
                for (k, _) in friends {
                    let friend = FriendInfo.init(friends[k] as! Dictionary<String, Any>)
                    
                    if friend.state == FriendState.friends {
                        friendArray.append(friend)
                    } else if friend.state == FriendState.beInvited {
                        beIvitedArray.append(friend)
                    }
                }
                // To sort the list
                friendArray = friendArray.sorted(by: { $0.username < $1.username })
                beIvitedArray = beIvitedArray.sorted(by: { $0.username < $1.username })
                strongSelf.delegate?.friendshipDidGetList(friends: friendArray, beInvited: beIvitedArray)
            }
        })
    }
    
    override func search(_ email: String) {
        let friendNode = self.emailToNode(email)
        _refHandle = ref.child(friendNode).observe(.value, with: { [weak self] (snapshot) in
            guard let strongSelf = self else {return}
            if (snapshot.exists()) {
                let userInfo = snapshot.value as! Dictionary<String, Any>
                strongSelf.delegate?.friendshipDidSearch(email: userInfo[Constants.FirebaseKey.email] as? String, username: userInfo[Constants.FirebaseKey.username] as? String)
            } else {
                strongSelf.delegate?.friendshipDidSearch(email: nil, username: nil)
            }
            strongSelf.ref.child(friendNode).removeObserver(withHandle: strongSelf._refHandle)
        })
    }
    
    // Check my relationship to this email.
    override func checkRelationshipBy(email: String) {
        
        let myNode = self.emailToNode(MyProfile.shared.email)
        let friendNode = self.emailToNode(email)
        // Check the friend list for the relationship.
        _refHandle = ref.child("\(myNode)/friend").observe(.value, with: { [weak self](snapshot) in
            guard let strongSelf = self else {return}
            strongSelf.ref.child("\(myNode)/friend").removeObserver(withHandle: strongSelf._refHandle)
            if (snapshot.exists()) {
                // The friend list is not empty.
                let infos = snapshot.value as! Dictionary<String, Any>
                for (k, v) in infos {
                    if (k == friendNode) {
                        // This email is in the friend list.
                        let friendInfo = FriendInfo.init(v as! Dictionary<String, Any>)
                        strongSelf.delegate?.friendshipDidCheckRelationship(result: friendInfo.state)
                        return
                    }
                }
            }
            strongSelf.delegate?.friendshipDidCheckRelationship(result: .none)
        })
    }
    
    override func invite(email: String, username: String) {
        let friendNode = self.emailToNode(email)
        let myNode = self.emailToNode(MyProfile.shared.email)
        
        // On my side
        let friendInfo = FriendInfo.init(email: email, username: username, state: .invite)
        ref.child("\(myNode)/friend/\(friendNode)").setValue(friendInfo.generateDict())
        
        // On friend's side
        let myInfo = FriendInfo.init(email: MyProfile.shared.email, username: MyProfile.shared.username, state: .beInvited)
        ref.child("\(friendNode)/friend/\(myNode)").setValue(myInfo.generateDict())
        
    }
    
    override func accept(_ info: FriendInfo) {
        let friendNode = self.emailToNode(info.email)
        let myNode = self.emailToNode(MyProfile.shared.email)
        
        // On my side
        var newFriendInfo = FriendInfo.init(info.generateDict())
        newFriendInfo.state = .friends
        ref.child("\(myNode)/friend/\(friendNode)").setValue(newFriendInfo.generateDict())
        
        // On friend's side
        let newMyInfo = FriendInfo.init(email: MyProfile.shared.email, username: MyProfile.shared.username, state: .friends)
        ref.child("\(friendNode)/friend/\(myNode)").setValue(newMyInfo.generateDict())
    }
    
    override func decline(_ info: FriendInfo) {
        let friendNode = self.emailToNode(info.email)
        let myNode = self.emailToNode(MyProfile.shared.email)
        
        let emptyInfo = Dictionary<String, Any>.init()
        ref.child("\(myNode)/friend/\(friendNode)").setValue(emptyInfo)
        ref.child("\(friendNode)/friend/\(myNode)").setValue(emptyInfo)
    }
}

