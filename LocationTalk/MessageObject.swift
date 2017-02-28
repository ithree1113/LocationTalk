//
//  MessageObject.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2017/2/28.
//  Copyright © 2017年 鄭宇翔. All rights reserved.
//

import UIKit

protocol MessageDelegate: class {
    func messageDidGetList(_ list: [Message])
}

class MessageObject: NSObject {

    weak var delegate: MessageDelegate?
    
    required override init() {
        
    }
    
    func send(message: Message) {
        
    }
    func getMessageList() {
        
    }
    func unlock(message: Message) {
        
    }
}
