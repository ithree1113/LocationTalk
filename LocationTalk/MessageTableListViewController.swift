//
//  MessageTableListViewController.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2017/1/29.
//  Copyright © 2017年 鄭宇翔. All rights reserved.
//

import UIKit

class MessageTableListViewController: UIViewController, UITableViewDataSource, MessageDelegate {

    @IBOutlet weak var messageListTable: UITableView! {
        didSet {
            messageListTable.dataSource = self
        }
    }
    
    var messageUtility: MessageProtocol! {
        didSet {
            messageUtility.delegate = self
        }
    }
    
    var messageArray: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        messageUtility = Database().message()
        messageUtility.getMessageList()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cell.messageList, for: indexPath)
        
        cell.textLabel?.text = messageArray[indexPath.row].username
        cell.detailTextLabel?.text = messageArray[indexPath.row].time
        
        return cell
    }
}

// MARK: - MessageUtilityDelegate
extension MessageTableListViewController {
    func messageDidGetList(_ list: [Message]) {
        messageArray = list
        messageListTable.reloadData()
    }
}
