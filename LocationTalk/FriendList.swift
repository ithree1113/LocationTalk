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
    func didGetFriendList(friends friendArray: [FriendInfo], beInvited beIvitedArray: [FriendInfo])
}


class FriendList: AccountProtocol {
    
    let ref: FIRDatabaseReference!
    fileprivate var _refHandle: FIRDatabaseHandle! = 0
    weak var delagate: FriendListDelegate?
    
    init() {
        self.ref = FIRDatabase.database().reference()
    }
    
    func getFriendList() {
        
        let myState = MyState.sharedInstance
        let myNode = self.emailToNode(myState.email!)
        
        _refHandle = ref.child("\(myNode)/friend").observe(.value, with: { [weak self](snapshot) in
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
                strongSelf.delagate?.didGetFriendList(friends: friendArray, beInvited: beIvitedArray)
            }
        })
    }
    
    deinit {
        print("FriendList deinit")
        let myState = MyState.sharedInstance
        let myNode = self.emailToNode(myState.email!)
        ref.child("\(myNode)/friend").removeObserver(withHandle: _refHandle)
    }


//    func checkFriend(_ info: FriendInfo, ref: FIRDatabaseReference) -> FriendState {
//        let myState = MyState.sharedInstance
//        let selfNode = self.emailToNode(myState.email!)
//        let targetNode = self.emailToNode(info.email)
//        
//        _refHandle = ref.child("\(selfNode)/friend/\(targetNode)").observe(.value, with: { (sanpshot) in
//            if sanpshot.exists() {
//                return FriendState.friends
//            } else {
//                return FriendState.none
//            }
//        })
//    }
    
    
    
}
