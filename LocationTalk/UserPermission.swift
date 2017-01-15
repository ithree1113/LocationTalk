//
//  UserPermission.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2017/1/15.
//  Copyright © 2017年 鄭宇翔. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class UserPermission: NSObject, CLLocationManagerDelegate {
    
    weak var delegate: UIViewController?
    
    fileprivate let locationManager = CLLocationManager()
    
    func location() {
//        locationManager.delegate = self.delegate as! CLLocationManagerDelegate?
        let status: CLAuthorizationStatus = CLLocationManager.authorizationStatus()
        if status == CLAuthorizationStatus.notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    
}
