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
    weak var delegate: MessageDelegate?
    
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
    
    func getMessageList() {
        let myNode = self.emailToNode(MyProfile.shared.email)
        
        _refHandle = ref.child("\(myNode)/receive").observe(.value, with: { [weak self](snapshot) in
            guard let strongSelf = self else {return}
            if snapshot.exists() {
                let messages = snapshot.value as! Dictionary<String, Any>
                
                var messageList: [Message] = []
                
                for(k, v) in messages {
                    var message = Message(message: v as! Dictionary<String, Any>)
                    message.key = k
                    messageList.append(message)
                }
                messageList = messageList.sorted(by: {$0.time < $1.time})
                strongSelf.delegate?.messageDidGetList(messageList)
            }
        })
    }
    
    func unlock(message: Message) {
        let myNode = self.emailToNode(MyProfile.shared.email)
        var message = message
        message.isLock = false
        ref.child("\(myNode)/receive/\(message.key)").setValue(message.generateDict())
    }
    
    
}
