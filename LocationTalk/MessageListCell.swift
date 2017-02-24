//
//  MessageListCell.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2017/2/23.
//  Copyright © 2017年 鄭宇翔. All rights reserved.
//

import UIKit

class MessageListCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var lockView: UIView! {
        didSet {
            lockView.makeCircle(radius: 8)
        }
    }
    @IBOutlet weak var placeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
