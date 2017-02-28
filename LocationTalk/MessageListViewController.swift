//
//  MessageListViewController.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2017/1/29.
//  Copyright © 2017年 鄭宇翔. All rights reserved.
//

import UIKit
import CoreLocation

class MessageListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ShowMessageViewDelegate, CLLocationManagerDelegate, MessageDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var messageListTable: UITableView! {
        didSet {
            messageListTable.dataSource = self
            messageListTable.delegate = self
        }
    }
    
    let messageUtility: MessageObject! = Database().message()
    
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
    
    let userPermission = UserPermission()
    var messageArray: [Message] = []
    var messageSelected: Message!
    var cellRect: CGRect = CGRect.zero
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialViewStatus()
        configDelegate()
        userPermission.location()
        messageUtility.getMessageList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print("MessageListViewController deinit")
    }
    
    @IBAction func modeSwitchChange(_ sender: UISwitch) {
        if sender.isOn { // Switch to MapMode
            self.titleLabel.text = Constants.SwitchMode.mapMode
//            self.messageListByMapView.isHidden = false
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
//                self.messageListByMapView.alpha = 1
                self.messageListTable.alpha = 0
            }, completion: { (finish) in
                self.messageListTable.isHidden = true
            })
        } else {
            self.titleLabel.text = Constants.SwitchMode.tableMode
            self.messageListTable.isHidden = false
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
                self.messageListTable.alpha = 1
//                self.messageListByMapView.alpha = 0
            }, completion: { (finish) in
//                self.messageListByMapView.isHidden = true
            })
        }
    }
    
    func initialViewStatus() {
        self.titleLabel.text = Constants.SwitchMode.tableMode
        self.titleLabel.textColor = UIColor.white
//        self.messageListByMapView.isHidden = true
//        self.messageListByMapView.alpha = 0
        
        showMessageView = ShowMessageView.init(frame: CGRect.zero)
        self.view.addSubview(showMessageView)

    }
    
    func configDelegate() {
        messageUtility.delegate = self
        locationManager.delegate = self
    }

}

// MARK: - UITableViewDataSource
extension MessageListViewController {
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
extension MessageListViewController {
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

// MARK: - ShowMessageViewDelegate
extension MessageListViewController {
    func ShowMessageViewCloseBtnPressed(_ sender: UIButton) {
        locationManager.stopUpdatingLocation()
        MyAnimation().disappear(view: showMessageView)
    }
}

// MARK: - CLLocationManagerDelegate
extension MessageListViewController {
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
extension MessageListViewController {
    func messageDidGetList(_ list: [Message]) {
        messageArray = list
        messageListTable.reloadData()
    }
}
