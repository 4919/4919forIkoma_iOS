//
//  LeftToRightAnimationController.swift
//  WebImageCollector
//
//  Created by fuhi1983 on 2015/01/22.
//  Copyright (c) 2015年 ffsj. All rights reserved.
//

import UIKit

class LeftToRightAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let finalFrame = transitionContext.finalFrame(for: toViewController)
        
        let containerView = transitionContext.containerView
        
        // 遷移前の状態
        let screenBounds = UIScreen.main.bounds
        toViewController.view.frame = finalFrame.offsetBy(dx: screenBounds.size.width * -1, dy: 0)
        
        containerView.addSubview(toViewController.view)
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, animations: {
            toViewController.view.frame = finalFrame
        }, completion: {
            finished in
            transitionContext.completeTransition(true)
        })
    }
}
