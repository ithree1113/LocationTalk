//
//  Database.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2017/1/28.
//  Copyright © 2017年 鄭宇翔. All rights reserved.
//

import UIKit

class Database: NSObject {

    
    func auth() -> AuthProtocol! {
        
        switch Constants.database {
        case "Firebase":
            return FirebaseAuth.init()
        default:
            return nil
        }
    }
    
    func friendship() -> FriendshipProtocol! {
        switch Constants.database {
        case "Firebase":
            return FirebaseFriend.init()
        default:
            return nil
        }
    }
    
    func message() -> MessageProtocol! {
        switch Constants.database {
        case "Firebase":
            return MessageUtility.init()
        default:
            return nil
        }
    }
    
    
}
