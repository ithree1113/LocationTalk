//
//  MessageTableListViewController.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2017/1/29.
//  Copyright © 2017年 鄭宇翔. All rights reserved.
//

import UIKit

class MessageTableListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MessageDelegate, ShowMessageViewDelegate {

    @IBOutlet weak var messageListTable: UITableView! {
        didSet {
            messageListTable.dataSource = self
            messageListTable.delegate = self
        }
    }
    
    var messageUtility: MessageProtocol! {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        messageUtility = Database().message()
        messageUtility.getMessageList()

        showMessageView = ShowMessageView.init(frame: CGRect.zero)
        self.view.addSubview(showMessageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cell.messageList, for: indexPath)
        
        cell.textLabel?.text = messageArray[indexPath.row].username
        cell.detailTextLabel?.text = messageArray[indexPath.row].time
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MessageTableListViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showMessageView.isHidden = false
        showMessageView.messageTextField.text = messageArray[indexPath.row].content
        MyAnimation().present(view: showMessageView, to: UIScreen.main.bounds.size.height/2)
    }
}

// MARK :- ShowMessageViewDelegate
extension MessageTableListViewController {
    func ShowMessageViewCloseBtnPressed(_ sender: UIButton) {
        MyAnimation().disappear(view: showMessageView)
    }
}


// MARK: - MessageUtilityDelegate
extension MessageTableListViewController {
    func messageDidGetList(_ list: [Message]) {
        messageArray = list
        messageListTable.reloadData()
    }
}
