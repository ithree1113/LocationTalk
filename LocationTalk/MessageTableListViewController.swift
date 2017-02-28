//
//  MessageTableListViewController.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2017/1/29.
//  Copyright © 2017年 鄭宇翔. All rights reserved.
//

import UIKit
import CoreLocation

class MessageTableListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MessageDelegate, ShowMessageViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var messageListTable: UITableView! {
        didSet {
            messageListTable.dataSource = self
            messageListTable.delegate = self
        }
    }
    
    var messageUtility: MessageObject! {
        didSet {
            messageUtility.delegate = self
        }
    }
    
    var showMessageView: ShowMessageView! {
        didSet {
            showMessageView.delegate = self
            showMessageView.frame.size.width = UIScreen.main.bounds.size.width
            showMessageView.frame.size.height = UIScreen.main.bounds.size.height/2
            showMessageView.frame.origin.x = UIScreen.main.bounds.origin.x
            showMessageView.frame.origin.y = UIScreen.main.bounds.size.height
            showMessageView.isHidden = true
        }
    }
    
    var messageArray: [Message] = []
    var messageSelected: Message!
    var cellRect: CGRect = CGRect.zero
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        messageUtility = Database().message()
        messageUtility.getMessageList()

        showMessageView = ShowMessageView.init(frame: CGRect.zero)
        self.view.addSubview(showMessageView)
        
        locationManager.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("\(messageArray)")
    }
    
    deinit {
        print("MessageTableListViewController deinit")
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

// MARK: - UITableViewDataSource
extension MessageTableListViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cell.messageList) as! MessageListCell?
        
        if cell == nil {
            let nib = UINib.init(nibName: Constants.Xib.messageListCell, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: Constants.Cell.messageList)
            cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cell.messageList) as! MessageListCell?
        }
        
        cell?.nameLabel.text = messageArray[indexPath.row].username
        cell?.timeLabel.text = messageArray[indexPath.row].time
        cell?.placeLabel.text = messageArray[indexPath.row].place
        if messageArray[indexPath.row].isLock {
            cell?.lockView.backgroundColor = UIColor.red
        } else {
            cell?.lockView.backgroundColor = UIColor.green
        }
        cellRect = cell!.frame
        return cell!
    }
}

// MARK: - UITableViewDelegate
extension MessageTableListViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        messageSelected = messageArray[indexPath.row]
        
        if !(messageSelected.isLock) {
            showMessageView.messageTextField.textColor = UIColor.white
            showMessageView.messageTextField.text = messageSelected.content
            MyAnimation().present(view: showMessageView, to: UIScreen.main.bounds.size.height/2)
        } else {
            locationManager.startUpdatingLocation()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellRect.size.height
    }
    
}

// MARK :- ShowMessageViewDelegate
extension MessageTableListViewController {
    func ShowMessageViewCloseBtnPressed(_ sender: UIButton) {
        locationManager.stopUpdatingLocation()
        MyAnimation().disappear(view: showMessageView)
    }
}


// MARK: - CLLocationManagerDelegate
extension MessageTableListViewController {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        if messageSelected.isInTheRange(user: locations.last?.coordinate) {
            showMessageView.messageTextField.textColor = UIColor.white
            showMessageView.messageTextField.text = messageSelected.content
            messageUtility.unlock(message: messageSelected)
            manager.stopUpdatingLocation()
        } else {
            showMessageView.messageTextField.textColor = UIColor.yellow
            showMessageView.messageTextField.text = "This message is locked.\n Please go to \"\(messageSelected.place!)\" to unlock."
        }
        if showMessageView.isHidden {
            MyAnimation().present(view: showMessageView, to: UIScreen.main.bounds.size.height/2)
        }
    }
}

// MARK: - MessageUtilityDelegate
extension MessageTableListViewController {
    func messageDidGetList(_ list: [Message]) {
        messageArray = list
        messageListTable.reloadData()
    }
}
