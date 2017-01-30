//
//  ShowMessageView.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2017/1/30.
//  Copyright © 2017年 鄭宇翔. All rights reserved.
//

import UIKit
protocol ShowMessageViewDelegate: class {
    func ShowMessageViewCloseBtnPressed(_ sender: UIButton)
}


class ShowMessageView: UIView {

    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var messageTextField: UITextView!
    
    weak var delegate: ShowMessageViewDelegate?
    
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
        let nib = UINib(nibName: "ShowMessageView", bundle: bundle)
        self.contentView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        self.contentView.frame = bounds
        self.addSubview(contentView)
    }
    
    
    @IBAction func closeBtnPressed(_ sender: UIButton) {
        self.delegate?.ShowMessageViewCloseBtnPressed(sender)
    }

}
