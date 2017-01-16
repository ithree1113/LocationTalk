//
//  MessageViewController.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2017/1/5.
//  Copyright © 2017年 鄭宇翔. All rights reserved.
//

import UIKit
import GooglePlaces

class MessageViewController: UIViewController, SendMessageHeaderViewDataSource, MyPlaceServicesProtocol, CLLocationManagerDelegate {

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
        let message = Message.init(friendSelected: friendSelected,
                                   place: placeSelected,
                                   time: headerView.timeLabel.text!,
                                   content: contentTextView.text)
        let messageUtility = MessageUtility.init()
        messageUtility.send(message: message)
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
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
    func getCurrentPlace(place: GMSPlace?, error: Error?) {
        if let error = error {
            print("\(error.localizedDescription)")
            return
        }
        
        if let place = place {
            placeSelected = place
            DispatchQueue.main.async {
                self.headerView.locationLabel.text = place.formattedAddress
            }
        }
    }
}
