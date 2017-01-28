//
//  AddFriendByEmailView.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2017/1/28.
//  Copyright © 2017年 鄭宇翔. All rights reserved.
//

import Foundation
import UIKit

protocol AddFriendByEmailViewDelegate: class {
    func addFriendByEmailViewShouldReturn(_ textField: UITextField, email: String)
    func addButtonDidPressed()
}

class AddFriendByEmailView: UIView, UITextFieldDelegate {
    
    @IBOutlet weak var searchText: UITextField! {
        didSet {
            searchText.delegate = self
        }
    }
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var addButton: UIButton!

    @IBOutlet weak var usernameResultLabel: UILabel! {
        didSet {
            usernameResultLabel.text = ""
        }
    }
    
    weak var delegate: AddFriendByEmailViewDelegate?
    
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
        let nib = UINib(nibName: "AddFriendByEmailView", bundle: bundle)
        self.contentView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        self.contentView.frame = bounds
        self.addSubview(contentView)
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        self.delegate?.addButtonDidPressed()
    }
}

// MARK: - UITextFieldDelegate
extension AddFriendByEmailView {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.delegate?.addFriendByEmailViewShouldReturn(textField, email: searchText.text!)
        
        return true
    }
    
}
