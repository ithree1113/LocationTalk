//
//  AcceptViewController.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2017/1/3.
//  Copyright © 2017年 鄭宇翔. All rights reserved.
//

import UIKit

class AcceptViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var invitationTable: UITableView!
    var beIvitedArray: [FriendInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.invitationTable.dataSource = self
        self.invitationTable.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print("AcceptViewController deinit")
    }
    
    @IBAction func pressDoneButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.beIvitedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cell.invitation, for: indexPath)
        
        cell.textLabel?.text = self.beIvitedArray[indexPath.row].username
        
        return cell
    }
    
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let alert = UIAlertController.init(title: "", message: "Do you accept this invitation?", preferredStyle: .actionSheet)
        let accept = UIAlertAction.init(title: "Accept", style: .default) { (action) in
            let addFriend = AddFriend.init()
            addFriend.accept(self.beIvitedArray[indexPath.row])
            self.beIvitedArray.remove(at: indexPath.row)
            self.invitationTable.deleteRows(at: [indexPath], with: .automatic)
        }
        let decline = UIAlertAction.init(title: "Decline", style: .destructive) { (action) in
            let addFriend = AddFriend.init()
            addFriend.decline(self.beIvitedArray[indexPath.row])
            self.beIvitedArray.remove(at: indexPath.row)
            self.invitationTable.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let decideLater = UIAlertAction.init(title: "Decide later", style: .default) { (action) in
            
        }
        alert.addAction(accept)
        alert.addAction(decideLater)
        alert.addAction(decline)
        self.present(alert, animated: true, completion: nil)
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