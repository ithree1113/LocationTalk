//
//  Firebase.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2017/1/28.
//  Copyright © 2017年 鄭宇翔. All rights reserved.
//

import Foundation
import Firebase

class MyFirebase {
    
    var ref: FIRDatabaseReference!
    
    init() {
        self.ref = FIRDatabase.database().reference()
    }
}
