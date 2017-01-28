//
//  FriendshipProtocol.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2017/1/28.
//  Copyright © 2017年 鄭宇翔. All rights reserved.
//

import Foundation
import Firebase

protocol FriendshipDelegate: class {
    func friendshipDidGetList(friends friendsArray: [FriendInfo], beInvited beIvitedArray: [FriendInfo])
    func friendshipDidSearch(email: String?, username: String?)
    func friendshipDidCheckRelationship(result: FriendState)
}

protocol FriendshipProtocol {
    
    weak var delegate: FriendshipDelegate? {get set}
    
    func getFriendListFrom(_ email: String)
    func search(_ email: String)
    func checkRelationshipBy(email: String)
    func invite(email: String, username: String)
    func accept(_ info: FriendInfo)
    func decline(_ info: FriendInfo)
}

extension FriendshipDelegate {
    func friendshipDidGetList(friends friendsArray: [FriendInfo], beInvited beIvitedArray: [FriendInfo]) {
    }
    func friendshipDidSearch(email: String?, username: String?) {
    }
    func friendshipDidCheckRelationship(result: FriendState) {
    }
    
}
