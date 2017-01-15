//
//  CustomPresentAnimationController.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2017/1/9.
//  Copyright © 2017年 鄭宇翔. All rights reserved.
//

import UIKit

class CustomPresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        let fromVC = transitionContext.viewController(forKey: .from)
//        let toVC = transitionContext.viewController(forKey: .to)
//        let finalFrame = transitionContext.finalFrame(for: toVC!)
//        let containerView = transitionContext.containerView
//        let bounds = UIScreen.main.bounds
//        toVC?.view.alpha = 0
//        toVC?.view.frame = finalFrame.offsetBy(dx: 0, dy: 0)
//        containerView.addSubview(toVC!.view)
//        
////        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { 
//        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: .curveLinear, animations: {
//            toVC?.view.alpha = 1
//            toVC?.view.frame = finalFrame
//            
//        }) { (finish) in
//            transitionContext.completeTransition(true)
////            fromVC?.view.alpha = 1
//        }
    }
    
}
