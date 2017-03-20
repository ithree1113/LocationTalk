//
//  Database.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2017/1/28.
//  Copyright © 2017年 鄭宇翔. All rights reserved.
//

import UIKit

enum DatabaseError: Error {
    case Database_Object_Cant_Be_Created
}

class Database: NSObject {

    func auth() throws -> AuthObject {
        let className = "\(Constants.database)"+"Auth"
        let authClass = NSClassFromString("LocationTalk."+"\(className)") as? AuthObject.Type
        if let authClass = authClass {
            return authClass.init()
        }
        
        throw DatabaseError.Database_Object_Cant_Be_Created
    }
    
    func friendship() throws -> FriendshipObject {
        let className = "\(Constants.database)"+"Friendship"
        let friendshipClass = NSClassFromString("LocationTalk."+"\(className)") as? FriendshipObject.Type
        if let friendshipClass = friendshipClass {
            return friendshipClass.init()
        }
        
        throw DatabaseError.Database_Object_Cant_Be_Created
    }
    
    func message() throws -> MessageObject {
        let className = "\(Constants.database)"+"Message"
        let messageClass = NSClassFromString("LocationTalk."+"\(className)") as? MessageObject.Type
        if let messageClass = messageClass {
            return messageClass.init()
        }
        
        throw DatabaseError.Database_Object_Cant_Be_Created
    }
    
}
