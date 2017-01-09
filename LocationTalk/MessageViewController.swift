//
//  MessageViewController.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2017/1/5.
//  Copyright © 2017年 鄭宇翔. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController, SendMessageHeaderViewDataSource {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendButtonPressed(_ sender: UIBarButtonItem) {
        let message = Message.init(email: friendSelected.email, username: friendSelected.username, time: headerView.timeLabel.text!, content: contentTextView.text)
        let messageSender = MessageSender.init()
        messageSender.send(message: message)
        
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
}
