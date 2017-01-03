//
//  AddFriend.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2016/12/30.
//  Copyright © 2016年 鄭宇翔. All rights reserved.
//

import Foundation
import Firebase

protocol AddFriendDelegate: class {
    func didSearchFriend(email: String, username: String)
    func notSearchFriend()
}


class AddFriend: AccountProtocol {
    let ref: FIRDatabaseReference!
    fileprivate var _refHandle: FIRDatabaseHandle!
    weak var delagate: AddFriendDelegate?
    
    init() {
        self.ref = FIRDatabase.database().reference()
    }
    
    func searchFriends(_ target: String) {
        let friendNode = self.emailToNode(target)
        _refHandle = ref.child(friendNode).observe(.value, with: { [weak self] (snapshot) in
            guard let strongSelf = self else {return}
            if (snapshot.exists()) {
                let userInfo = snapshot.value as! Dictionary<String, Any>
                strongSelf.delagate?.didSearchFriend(email: (userInfo[Constants.FirebaseKey.email] as? String)!, username: (userInfo[Constants.FirebaseKey.username] as? String)!)
            } else {
                strongSelf.delagate?.notSearchFriend()
            }
            strongSelf.ref.child(friendNode).removeObserver(withHandle: strongSelf._refHandle)
        })
    }
}
