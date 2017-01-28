//
//  MessageSender.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2017/1/9.
//  Copyright © 2017年 鄭宇翔. All rights reserved.
//

import UIKit
import Firebase

class MessageUtility: MyFirebase, AccountProtocol, MessageProtocol {

    fileprivate var _refHandle: FIRDatabaseHandle!
    
    func send(message: Message) {
        let friendNode = self.emailToNode(message.email)
        let myNode = self.emailToNode(MyProfile.shared.email)
        
        // On my side
        ref.child("\(myNode)/send").childByAutoId().setValue(message.generateDict())
        
        // On friend's side
        var receiveMessage = Message.init(message: message.generateDict())
        receiveMessage.email = MyProfile.shared.email
        receiveMessage.username = MyProfile.shared.username
        ref.child("\(friendNode)/receive").childByAutoId().setValue(receiveMessage.generateDict())
    }
    
    
}
