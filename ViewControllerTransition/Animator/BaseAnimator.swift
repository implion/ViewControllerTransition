//
//  BaseAnimator.swift
//  ViewControllerTransition
//
//  Created by 文圣灵 on 2018/5/17.
//  Copyright © 2018年 ShengLing. All rights reserved.
//

import Foundation
import UIKit

class BaseAnimator: NSObject, Animator {
    
    var isPresented = true
    
    var animationDuration: TimeInterval {
        return 1
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromViewController = transitionContext.viewController(forKey: .from) else { return }
        guard let toViewController = transitionContext.viewController(forKey: .to) else { return }
        
        let containView = transitionContext.containerView
        let fromView = transitionContext.view(forKey: .from) ?? fromViewController.view!
        let toView = transitionContext.view(forKey: .to) ?? toViewController.view!
        
        fromView.frame = transitionContext.initialFrame(for: fromViewController)
        toView.frame = transitionContext.finalFrame(for: toViewController)
        
        if isPresented {
            fromView.layer.opacity = 1.0
            toView.layer.opacity = 0.0
            toView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }
        
        let animationDuration = transitionDuration(using: transitionContext)
        
        containView.addSubview(toView)
        
        UIView.animate(withDuration: animationDuration, animations: {
            fromView.layer.opacity = 0.0
            toView.layer.opacity = 1.0
            toView.transform = CGAffineTransform.identity
            fromView.transform = CGAffineTransform(scaleX: 2, y: 2)
        }, completion: { (success) in
            if success {
                transitionContext.completeTransition(true)
            }
        })
    }
    
    
}
