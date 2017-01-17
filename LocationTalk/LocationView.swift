//
//  LocationView.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2017/1/16.
//  Copyright © 2017年 鄭宇翔. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps

protocol LocationViewDelegate: class {
    func searchBarTextDidChange(searchText: String)
    func locatonViewDidSelect(result: GMSAutocompletePrediction)
}

//@IBDesignable
class LocationView: UIView, UITableViewDataSource, UISearchBarDelegate, UITableViewDelegate {

    @IBOutlet var contentView: UIView!

    @IBOutlet weak var locationMap: GMSMapView! {
        didSet {
            locationMap.isMyLocationEnabled = false
            locationMap.accessibilityElementsHidden = false
        }
    }

    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    @IBOutlet weak var resultTableView: UITableView! {
        didSet {
            resultTableView.dataSource = self
            resultTableView.delegate = self
            resultTableView.backgroundColor = UIColor(colorLiteralRed: 1, green: 1, blue: 1, alpha: 0.7)
            resultTableView.isHidden = true  // tableview is hidden when init.
        }
    }
    
    var searchResultArray: [GMSAutocompletePrediction] = [] {
        didSet {
            // If there is the result, show tableview to display.
            if searchResultArray.count == 0 {
                resultTableView.isHidden = true
            } else {
                resultTableView.isHidden = false
            }
            resultTableView.reloadData()
        }
    }
    
    weak var delegate: LocationViewDelegate?
    
    var placeSelected: GMSPlace! {
        didSet {
            if let placeSelected = placeSelected {
                let cameraUpdate = GMSCameraUpdate.setTarget(placeSelected.coordinate, zoom: 15)
                locationMap.animate(with: cameraUpdate)
                
                let marker = GMSMarker.init(position: placeSelected.coordinate)
                marker.title = placeSelected.name
                marker.map = locationMap
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViewFromNib()
    }
    
    private func initViewFromNib() {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "LocationView", bundle: bundle)
        self.contentView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        self.contentView.frame = bounds
        self.addSubview(contentView)
    }
    
    fileprivate func setScreenToDefault() {
        searchBar.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
        resultTableView.isHidden = true
    }
    
}

// MARK: - UITableViewDataSource
extension LocationView {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cell.locationResult)
        
        if cell == nil {
            cell = UITableViewCell.init(style: .value1, reuseIdentifier: Constants.Cell.locationResult)
        }
        cell?.backgroundColor = UIColor.clear
        cell?.textLabel?.text = searchResultArray[indexPath.row].attributedPrimaryText.string
        cell?.detailTextLabel?.text = searchResultArray[indexPath.row].attributedSecondaryText?.string
        return cell!
    }
}

// MARK: - UITableViewDelegate
extension LocationView {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.delegate?.locatonViewDidSelect(result: searchResultArray[indexPath.row])
        setScreenToDefault()
    }
}

// MARK: - UISearchBarDelegate
extension LocationView {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText.characters.count == 0) {
            // tableview is hidden if searchbar is empty
            resultTableView.isHidden = true
        } else {
            self.delegate?.searchBarTextDidChange(searchText: searchText)
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        setScreenToDefault()
    }
}

extension LocationViewDelegate {
    func searchBarTextDidChange(searchText: String) {
    }
    func locatonViewDidSelect(result: GMSAutocompletePrediction) {
    }
}
