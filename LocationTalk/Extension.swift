//
//  Extension.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2017/2/23.
//  Copyright © 2017年 鄭宇翔. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func makeCircle(radius: Int) {
        let maskPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize.init(width: radius, height: radius))
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        
        self.layer.mask = maskLayer
    }
}
