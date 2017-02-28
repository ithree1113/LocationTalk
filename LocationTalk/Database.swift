//
//  Database.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2017/1/28.
//  Copyright © 2017年 鄭宇翔. All rights reserved.
//

import UIKit

class Database: NSObject {

    
    func auth() -> AuthObject! {
        let className = "\(Constants.database)"+"Auth"
        let authClass = NSClassFromString("LocationTalk."+"\(className)") as! AuthObject.Type
        return authClass.init()
    }
    
    func friendship() -> FriendshipObject! {
        let className = "\(Constants.database)"+"Friendship"
        let friendshipClass = NSClassFromString("LocationTalk."+"\(className)") as! FriendshipObject.Type
        return friendshipClass.init()
    }
    
    func message() -> MessageObject! {
        let className = "\(Constants.database)"+"Message"
        let messageClass = NSClassFromString("LocationTalk."+"\(className)") as! MessageObject.Type
        return messageClass.init()
    }
    
}
