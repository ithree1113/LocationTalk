//
//  LocationService.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2017/1/15.
//  Copyright © 2017年 鄭宇翔. All rights reserved.
//

import Foundation
import GooglePlaces

protocol MyPlaceServicesProtocol: class {
    func getCurrentPlace(place: GMSPlace?, error: Error?)
}


class MyPlaceServices {
    
    static var sharedInstance = MyPlaceServices()
    
    fileprivate let placeClient: GMSPlacesClient = GMSPlacesClient.shared()
    
    weak var delegate: MyPlaceServicesProtocol?
    
    private init() {
        
    }
    
    func currentPlace() {
        placeClient.currentPlace { (placeLikelihoodList, error) in
            if let error = error {
                self.delegate?.getCurrentPlace(place: nil, error: error)
                return
            }
            
            if let placeLikelihoodList = placeLikelihoodList {
                let place = placeLikelihoodList.likelihoods.max(by: { $0.likelihood < $1.likelihood })?.place
                self.delegate?.getCurrentPlace(place: place, error: error)
            }
        }
    }
    
    
    
}

extension MyPlaceServicesProtocol {
    func getCurrentPlace(place: GMSPlace?, error: Error?) {
    }
}
