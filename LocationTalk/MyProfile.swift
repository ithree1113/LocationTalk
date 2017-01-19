//
//  MyInfo.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2016/12/29.
//  Copyright © 2016年 鄭宇翔. All rights reserved.
//

import UIKit

class MyProfile: NSObject {
    static let shared = MyProfile()
    
    var email: String = ""
    var username: String = ""
    
    func signedIn(email: String, username: String) {
        self.email = email
        self.username = username
    }
    
    func signedOut() {
        self.email = ""
        self.username = ""
    }
}
