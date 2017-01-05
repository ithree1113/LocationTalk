//
//  Constants.swift
//
//  Created by 鄭宇翔 on 2016/12/9.
//  Copyright © 2016年 鄭宇翔. All rights reserved.
//

import Foundation

struct Constants {
    struct Segue {
        static let loginToMain = "loginToMain"
        static let signupToMain = "signupToMain"
        static let loginToSignUp = "loginToSignUp"
        static let listToAdd = "listToAdd"
        static let listToAccept = "listToAccept"
        static let listToMessage = "listToMessage"
    }
    
    struct FirebaseKey {
        static let email = "email"
        static let username = "username"
        static let password = "password"
        static let state = "state"
    }
    
    struct ErrorAlert {
        static let alertTitle = "Oops!"
        static let loginMissingMessage = "Don't forget to enter your email, password, or a username."
    }
    
    struct Cell {
        static let friendList = "friend"
        static let invitation = "invitation"
    }
}
