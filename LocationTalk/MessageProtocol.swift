//
//  MessageProtocol.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2017/1/28.
//  Copyright © 2017年 鄭宇翔. All rights reserved.
//

import Foundation
protocol MessageDelegate: class {
    func messageDidGetList(_ list: [Message])
}

protocol MessageProtocol {
    
    weak var delegate: MessageDelegate? {get set}
    func send(message: Message)
    func getMessageList()
    func unlock(message: Message)
}
