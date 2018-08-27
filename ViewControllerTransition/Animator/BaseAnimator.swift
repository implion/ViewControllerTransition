//
//  BaseAnimator.swift
//  ViewControllerTransition
//
//  Created by 文圣灵 on 2018/5/17.
//  Copyright © 2018年 ShengLing. All rights reserved.
//

import Foundation
import UIKit

class BaseAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
//    let animator: Animator
//
//    init(_ type: AnimatorType) {
//        self.animator = Animator(type: type)
//    }
    
    var animationDuration: TimeInterval {
        return 0.35
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
//        guard let fromViewController = transitionContext.viewController(forKey: .from) else { return }
//        guard let toViewController = transitionContext.viewController(forKey: .to) else { return }
        
//        let containerView = transitionContext.containerView
//        let fromView = transitionContext.view(forKey: .from) ?? fromViewController.view!
//        let toView = transitionContext.view(forKey: .to) ?? toViewController.view!
//
//        fromView.frame = transitionContext.initialFrame(for: fromViewController)
//        toView.frame = transitionContext.finalFrame(for: toViewController)
//
//        let animationDuration = transitionDuration(using: transitionContext)
//
//
//        switch animator.type {
//        case .alpha:
//            containerView.addSubview(toView)
//            toView.alpha = 0.0
//            UIView.animate(withDuration: animationDuration, delay: 0.0, options: .curveEaseInOut, animations: {
//                toView.alpha = 1.0
//                toView.transform = CGAffineTransform.identity
//            }, completion: { finish in
//                transitionContext.completeTransition(true)
//            })
//        case .transform:
//            containerView.addSubview(toView)
//            var transform = CATransform3D()
//            transform.m34 = -1.0/500
//            toView.layer.sublayerTransform = transform
//            toView.layer.transform = CATransform3DMakeRotation(-CGFloat(Double.pi), 0, 1, 0)
//            UIView.animate(withDuration: animationDuration, delay: 0.0, options: .curveEaseOut, animations: {
//                toView.layer.transform = CATransform3DIdentity
//            }, completion: { _ in
//                transitionContext.completeTransition(true)
//            })
//        }
        
//        containerView.addSubview(toView)
       
//        let configure = AnimatorConfigure(from: fromView, to: toView, container: containerView, duration: animationDuration) {
//
//            let cancelled = transitionContext.transitionWasCancelled
//            transitionContext.completeTransition(!cancelled)
//        }
//        animator.animator(configure)
    }
    
    
}
