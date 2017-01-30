//
//  MyAnimation.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2017/1/30.
//  Copyright © 2017年 鄭宇翔. All rights reserved.
//

import Foundation
import UIKit

class MyAnimation {
    
    
    
    func present(view: UIView, to y: CGFloat) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            view.frame.origin.y = y
        }) { (finish) in
            
        }
    }
    
    func disappear(view: UIView) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            view.frame.origin.y = UIScreen.main.bounds.size.height
        }) { (finish) in
            view.isHidden = true
        }
    }
    
    
    
}
