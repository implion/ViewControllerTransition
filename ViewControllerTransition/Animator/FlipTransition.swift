//
//  FlipTransition.swift
//  ViewControllerTransition
//
//  Created by implion on 2018/8/30.
//  Copyright © 2018年 ShengLing. All rights reserved.
//

import Foundation
import UIKit

class FlipTransition: NSObject {
    var transitionContext: UIViewControllerContextTransitioning?
    var isPresenting: Bool = true
}

extension FlipTransition: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        guard let fromViewController = transitionContext.viewController(forKey: .from) else { return }
        guard let toViewController = transitionContext.viewController(forKey: .to) else { return }
        let duration = transitionDuration(using: transitionContext)
        let containView = transitionContext.containerView
        UIView.animate(withDuration: duration / 2, animations: {
            fromViewController.view.layer.transform = CATransform3DMakeRotation(CGFloat.pi / 2, 0, 1, 0)
        })
        containView.addSubview(toViewController.view)
        toViewController.view.layer.transform = CATransform3DMakeRotation(CGFloat.pi / 2, 0, 1, 0)
        UIView.animate(withDuration: duration / 2, delay: duration / 2, options: .curveEaseOut, animations: {
            toViewController.view.layer.transform = CATransform3DIdentity
        }, completion: { _ in
            transitionContext.completeTransition(true)
        })
    }
    
}

extension FlipTransition: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.isPresenting = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.isPresenting = false
        return self
    }
}
