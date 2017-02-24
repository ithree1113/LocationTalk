//
//  LocationViewController.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2017/1/15.
//  Copyright © 2017年 鄭宇翔. All rights reserved.
//

import UIKit
import GooglePlaces
protocol LocationViewControllerDelegate: class {
    func didChangeLocation(newPlace: GMSPlace)
}


class LocationViewController: UIViewController, LocationViewDelegate, MyPlaceServicesDelegate {

    @IBOutlet weak var locationView: LocationView! {
        didSet {
            locationView.delegate = self
        }
    }
    
    var placeSelected: GMSPlace!
    
    weak var delegate: LocationViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.locationView.placeSelected = placeSelected
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        self.delegate?.didChangeLocation(newPlace: placeSelected)
        dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - LocationViewDelegate
extension LocationViewController {
    func searchBarTextDidChange(searchText: String) {
        let myPlaceServices = MyPlaceServices.sharedInstance
        myPlaceServices.delegate = self
        myPlaceServices.autocomplete(searchText: searchText, filterType: .noFilter)
    }
    
    func locatonViewDidSelect(result: GMSAutocompletePrediction) {
        let myPlaceServices = MyPlaceServices.sharedInstance
        myPlaceServices.delegate = self
        myPlaceServices.placeBy(placeID: result.placeID!)
    }
}

// MARK: - MyPlaceServicesDelegate
extension LocationViewController {
    func getAutoComplete(results: [GMSAutocompletePrediction]?, error: Error?) {
        if let error = error {
            print("\(error.localizedDescription)")
            return
        }
        self.locationView.searchResultArray = results!
    }
    
    func getPlaceByPlaceID(place: GMSPlace?, error: Error?) {
        if let error = error {
            print("\(error.localizedDescription)")
            return
        }
        
        self.locationView.placeSelected = place
        placeSelected = place
    }
}
