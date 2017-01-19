//
//  FriendTool.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2016/12/29.
//  Copyright © 2016年 鄭宇翔. All rights reserved.
//

import Foundation
import Firebase

protocol FriendListDelegate: class {
    func friendListDidGetList(friends friendsArray: [FriendInfo], beInvited beIvitedArray: [FriendInfo])
}


class FriendList: AccountProtocol {
    
    let ref: FIRDatabaseReference!
    fileprivate var _refHandle: FIRDatabaseHandle! = 0
    weak var delagate: FriendListDelegate?
    
    init() {
        self.ref = FIRDatabase.database().reference()
    }
    
    func getFriendListFrom(_ email: String) {
        
        let node = self.emailToNode(email)
        
        _refHandle = ref.child("\(node)/friend").observe(.value, with: { [weak self](snapshot) in
            guard let strongSelf = self else {return}
            if (snapshot.exists()) {
                let friends = snapshot.value as! Dictionary<String, Any>
                
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
                friendArray = friendArray.sorted(by: { $0.username < $1.username })
                beIvitedArray = beIvitedArray.sorted(by: { $0.username < $1.username })
                strongSelf.delagate?.friendListDidGetList(friends: friendArray, beInvited: beIvitedArray)
            }
        })
    }
    
    deinit {
        print("FriendList deinit")
        let myNode = self.emailToNode(MyProfile.shared.email)
        ref.child("\(myNode)/friend").removeObserver(withHandle: _refHandle)
    }
    
}
