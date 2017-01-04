//
//  Constants.swift
//
//  Created by 鄭宇翔 on 2016/12/9.
//  Copyright © 2016年 鄭宇翔. All rights reserved.
//

import Foundation

struct Constants {
    struct Segue {
        static let userLogin = "userLogin"
        static let newUserLogin = "newUserLogin"
        static let listToAdd = "listToAdd"
        static let listToAccept = "listToAccept"
    }
    
    struct FirebaseKey {
        static let email = "email"
        static let username = "username"
        static let password = "password"
        static let state = "state"
    }
    
//    struct FriendState {
//        static let friends = "0"
//        static let invite = "1"
//        static let beInvited = "2"
//    }
    
    struct ErrorAlert {
        static let alertTitle = "Oops!"
        static let loginMissingMessage = "Don't forget to enter your email, password, and a username."
    }
    
    struct Cell {
        static let friendList = "friend"
        static let invitation = "invitation"
    }
}
