//
//  Message.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2017/1/9.
//  Copyright © 2017年 鄭宇翔. All rights reserved.
//

import Foundation
import GooglePlaces

struct Message {
    var username: String
    var email: String
    var time: String
    var content: String
    var place: String?
    var latitude: Double
    var longitude: Double
    var isLock: Bool
    var key: String = ""
    
    init(target: FriendInfo, place: GMSPlace, time: String, content: String) {
        self.email = target.email
        self.username = target.username
        self.place = place.formattedAddress
        self.latitude = place.coordinate.latitude
        self.longitude = place.coordinate.longitude
        self.time = time
        self.content = content
        self.isLock = true
    }
    
    init(message: Dictionary<String, Any>) {
        self.email = message[Constants.FirebaseKey.email]! as! String
        self.username = message[Constants.FirebaseKey.username]! as! String
        self.time = message[Constants.FirebaseKey.time]! as! String
        self.content = message[Constants.FirebaseKey.content]! as! String
        self.place = message[Constants.FirebaseKey.place] as! String?
        self.latitude = message[Constants.FirebaseKey.latitude]! as! Double
        self.longitude = message[Constants.FirebaseKey.longitude]! as! Double
        self.isLock = Bool.init(message[Constants.FirebaseKey.isLock]! as! String)!
    }
    
    func generateDict() -> Dictionary<String, Any> {
        
        let message = [Constants.FirebaseKey.email: self.email,
                       Constants.FirebaseKey.username: self.username,
                       Constants.FirebaseKey.time: self.time,
                       Constants.FirebaseKey.content: self.content,
                       Constants.FirebaseKey.place: self.place ?? "",
                       Constants.FirebaseKey.latitude: self.latitude,
                       Constants.FirebaseKey.longitude: self.longitude,
                       Constants.FirebaseKey.isLock: self.isLock.description] as [String : Any]
        
        return message 
    }
    
    func isInTheRange(user: CLLocationCoordinate2D?) -> Bool {
        
        if let user = user {
            let latDiff = user.latitude - self.latitude
            let lonDiff = user.longitude - self.longitude
            
            let distance = sqrt((latDiff * latDiff) + (lonDiff * lonDiff))
            
            if distance < Constants.range {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
}
