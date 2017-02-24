//
//  MessageListViewController.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2017/1/29.
//  Copyright © 2017年 鄭宇翔. All rights reserved.
//

import UIKit

class MessageListViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageListByMapView: UIView!
    
    @IBOutlet weak var messageListByTableView: UIView!
    
    let userPermission = UserPermission()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        userPermission.location()
        initialViewStatus()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func modeSwitchChange(_ sender: UISwitch) {
        if sender.isOn { // Switch to MapMode
            self.titleLabel.text = Constants.SwitchMode.mapMode
            self.messageListByMapView.isHidden = false
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
                self.messageListByMapView.alpha = 1
                self.messageListByTableView.alpha = 0
            }, completion: { (finish) in
                self.messageListByTableView.isHidden = true
            })
        } else {
            self.titleLabel.text = Constants.SwitchMode.tableMode
            self.messageListByTableView.isHidden = false
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
                self.messageListByTableView.alpha = 1
                self.messageListByMapView.alpha = 0
            }, completion: { (finish) in
                self.messageListByMapView.isHidden = true
            })
        }
    }
    
    func initialViewStatus() {
        self.titleLabel.text = Constants.SwitchMode.tableMode
        self.titleLabel.textColor = UIColor.white
        self.messageListByMapView.isHidden = true
        self.messageListByMapView.alpha = 0
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
