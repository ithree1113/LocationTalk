//
//  FriendshipObject.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2017/2/24.
//  Copyright © 2017年 鄭宇翔. All rights reserved.
//

import Foundation

protocol FriendshipDelegate: class {
    func friendshipDidGetList(friends friendsArray: [FriendInfo], beInvited beIvitedArray: [FriendInfo])
    func friendshipDidSearch(email: String?, username: String?)
    func friendshipDidCheckRelationship(result: FriendState)
}

class FriendshipObject: NSObject {

    
    weak var delegate: FriendshipDelegate?
    
    required override init() {
        
    }
    
    func getFriendListFrom(_ email: String) {
        
    }
    func search(_ email: String) {
        
    }
    func checkRelationshipBy(email: String) {
        
    }
    func invite(email: String, username: String) {
        
    }
    func accept(_ info: FriendInfo) {
        
    }
    func decline(_ info: FriendInfo) {
        
    }
}

extension FriendshipDelegate {
    func friendshipDidGetList(friends friendsArray: [FriendInfo], beInvited beIvitedArray: [FriendInfo]) {
    }
    func friendshipDidSearch(email: String?, username: String?) {
    }
    func friendshipDidCheckRelationship(result: FriendState) {
    }
    
}
