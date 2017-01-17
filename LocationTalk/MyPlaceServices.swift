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
    func get(currentPlace: GMSPlace?, error: Error?)
    func getAutoComplete(results: [GMSAutocompletePrediction]?, error: Error?)
    func getPlaceByPlaceID(place: GMSPlace?, error: Error?)
}


class MyPlaceServices {
    
    static var sharedInstance = MyPlaceServices()
    
    fileprivate let placeClient: GMSPlacesClient = GMSPlacesClient.shared()
    
    weak var delegate: MyPlaceServicesDelegate?
    
    var autocompleteFilter: GMSPlacesAutocompleteTypeFilter = .noFilter
    
    private init() {
        
    }
    
    func currentPlace() {
        placeClient.currentPlace { (placeLikelihoodList, error) in
            if let error = error {
                self.delegate?.get(currentPlace: nil, error: error)
                return
            }
            
            if let placeLikelihoodList = placeLikelihoodList {
                let place = placeLikelihoodList.likelihoods.max(by: { $0.likelihood < $1.likelihood })?.place
                self.delegate?.get(currentPlace: place, error: error)
            }
        }
    }
    
    func autocomplete(searchText: String) {
        let filter = GMSAutocompleteFilter.init()
        filter.type = autocompleteFilter
        
        placeClient.autocompleteQuery(searchText, bounds: nil, filter: filter) { (results, error) in
            self.delegate?.getAutoComplete(results: results, error: error)
        }
    }
    
    func placeBy(placeID: String) {
        placeClient.lookUpPlaceID(placeID) { (place, error) in
            self.delegate?.getPlaceByPlaceID(place: place, error: error)
        }
    }
    
    
}

extension MyPlaceServicesDelegate {
    func get(currentPlace: GMSPlace?, error: Error?) {
    }
    func getAutoComplete(results: [GMSAutocompletePrediction]?, error: Error?) {
    }
    func getPlaceByPlaceID(place: GMSPlace?, error: Error?) {
    }
}
