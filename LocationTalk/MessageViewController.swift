//
//  MessageViewController.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2017/1/5.
//  Copyright © 2017年 鄭宇翔. All rights reserved.
//

import UIKit
import GooglePlaces

class MessageViewController: UIViewController, SendMessageHeaderViewDataSource, MyPlaceServicesDelegate, CLLocationManagerDelegate, LocationViewControllerDelegate {

    @IBOutlet weak var headerView: SendMessageHeaderView! {
        didSet {
            headerView.delegate = self
        }
    }
    @IBOutlet weak var contentTextView: UITextView! {
        didSet {
            contentTextView.text = ""
        }
    }
    
    var friendSelected: FriendInfo!
    let userPermission = UserPermission()
    var placeSelected: GMSPlace!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        userPermission.location()
        
        let myPlaceServices = MyPlaceServices.sharedInstance
        myPlaceServices.delegate = self
        myPlaceServices.currentPlace()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print("MessageViewController deinit")
    }
    
    @IBAction func sendButtonPressed(_ sender: UIBarButtonItem) {
        let message = Message.init(target: friendSelected,
                                   place: placeSelected,
                                   time: headerView.timeLabel.text!,
                                   content: contentTextView.text)
        let messageUtility = Database().message()
        messageUtility?.send(message: message)
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }


    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == Constants.Segue.messageToLocation {
            let locationVC = segue.destination as! LocationViewController
            locationVC.placeSelected = placeSelected
            locationVC.delegate = self
        }
    }
}

// MARK: - SendMessageHeaderViewDataSource
extension MessageViewController {
    func userNameInTheHeader() -> String {
        return friendSelected.username
    }
    
    func didLocationChangeBtnPressed() {
        performSegue(withIdentifier: Constants.Segue.messageToLocation, sender: nil)
    }
}

// MARK: - MyPlaceServiceProtocol
extension MessageViewController {
    func get(currentPlace: GMSPlace?, error: Error?) {
        if let error = error {
            print("\(error.localizedDescription)")
            return
        }
        
        placeSelected = currentPlace
        DispatchQueue.main.async {
            self.headerView.locationLabel.text = currentPlace!.formattedAddress
        }
    }
}

// MARK: - LocationViewControllerDelegate
extension MessageViewController {
    func didChangeLocation(newPlace: GMSPlace) {
        placeSelected = newPlace
        self.headerView.locationLabel.text = "\(newPlace.name)(\(newPlace.formattedAddress!))"
    }
}
