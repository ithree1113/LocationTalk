//
//  LocationService.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2017/1/15.
//  Copyright © 2017年 鄭宇翔. All rights reserved.
//

import Foundation
import GooglePlaces

protocol MyPlaceServicesDelegate: class {
    func myPlaceServices(_ myPlaceServices: MyPlaceServices, didGet currentPlace: GMSPlace?, error: Error?)
    func myPlaceServices(_ myPlaceServices: MyPlaceServices, didGetAutoComplete results: [GMSAutocompletePrediction]?, error: Error?)
    func myPlaceServices(_ myPlaceServices: MyPlaceServices, didSearch place: GMSPlace?, error: Error?)
}


class MyPlaceServices {
    
    static let sharedInstance = MyPlaceServices()
    
    fileprivate let placeClient: GMSPlacesClient = GMSPlacesClient.shared()
    
    weak var delegate: MyPlaceServicesDelegate?
    
    private init() {
        
    }
    
    func currentPlace() {
        placeClient.currentPlace {(placeLikelihoodList, error) in
            if let error = error {
                self.delegate?.myPlaceServices(self, didGet: nil, error: error)
                return
            }
            
            if let placeLikelihoodList = placeLikelihoodList {
                let currentPlace = placeLikelihoodList.likelihoods.max(by: { $0.likelihood < $1.likelihood })?.place
                self.delegate?.myPlaceServices(self, didGet: currentPlace, error: error)
            }
        }
    }
    
    func autocomplete(searchText: String, filterType: GMSPlacesAutocompleteTypeFilter) {
        let filter = GMSAutocompleteFilter.init()
        filter.type = filterType
        
        placeClient.autocompleteQuery(searchText, bounds: nil, filter: filter) { (results, error) in
            self.delegate?.myPlaceServices(self, didGetAutoComplete: results, error: error)
        }
    }
    
    func place(By placeID: String) {
        placeClient.lookUpPlaceID(placeID) { (place, error) in
            self.delegate?.myPlaceServices(self, didSearch: place, error: error)
        }
    }
    
    
}

extension MyPlaceServicesDelegate {
    func myPlaceServices(_ myPlaceServices: MyPlaceServices, didGet currentPlace: GMSPlace?, error: Error?) {
    }
    func myPlaceServices(_ myPlaceServices: MyPlaceServices, didGetAutoComplete results: [GMSAutocompletePrediction]?, error: Error?) {
    }
    func myPlaceServices(_ myPlaceServices: MyPlaceServices, didSearch place: GMSPlace?, error: Error?) {
    }
}
