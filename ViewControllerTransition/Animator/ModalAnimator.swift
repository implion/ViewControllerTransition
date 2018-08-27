//
//  Animator.swift
//  ViewControllerTransition
//
//  Created by 文圣灵 on 2018/5/17.
//  Copyright © 2018年 ShengLing. All rights reserved.
//

import Foundation
import UIKit

typealias AnimatorBody = (_ configure: AnimatorConfigure) -> ()

struct AnimatorConfigure {
    let from: UIView
    let to: UIView
    var duration: TimeInterval?
    var completionBlock: (()-> Void)?
}

enum PresentationType {
    case presented
    case dismiss
}

enum AnimationType {
    case opacity
    case scala
    case transformRotationY
    case transformY
    case path
}

class ModalAnimator: NSObject {
    
    let presentationType: PresentationType
    let animationType: AnimationType
    var configure: AnimatorConfigure?
    init(_ presentationType: PresentationType, animationType: AnimationType) {
        self.presentationType = presentationType
        self.animationType = animationType
    }
    
    var animator: AnimatorBody {
        switch animationType {
        case .opacity:
            return self.alphaAction
        case .scala:
            return self.scalaAction
        case .path:
            return self.pathAction
        case .transformRotationY:
            return self.transformRotationYAction
        case .transformY:
            return self.transformY
        }
    }
    
    func alphaAction(_ configure: AnimatorConfigure) {
        
        CATransaction.begin()
        CATransaction.setCompletionBlock(configure.completionBlock)
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 1
        animation.toValue = 0
        animation.duration = configure.duration ?? 0.25
        animation.delegate = self
        configure.from.layer.add(animation, forKey: "opacity")
        CATransaction.commit()
    }
    
    func scalaAction(_ configure: AnimatorConfigure) {
        UIView.animate(withDuration: configure.duration ?? 0.25, delay: 0.0, options: .curveEaseOut, animations: {
            configure.to.layer.transform = CATransform3DMakeScale(0.8, 0.8, 1)
        }, completion: { _ in
            if let block = configure.completionBlock {
                block()
            }
        })
    }
    
    func pathAction(_ configure: AnimatorConfigure) {
    }
    
    func transformRotationYAction(_ configure: AnimatorConfigure) {
        
    }
    
    func transformY(_ configure: AnimatorConfigure) {
        let toViewHeight = configure.to.bounds.height
        configure.to.transform = CGAffineTransform(translationX: 0, y: toViewHeight)
        UIView.animate(withDuration: configure.duration ?? 0.25, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: .curveEaseIn, animations: {
            configure.to.transform = CGAffineTransform.identity
        }, completion: { finish in
            if let block = configure.completionBlock {
                block()
            }
        })
    }
}

extension ModalAnimator: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            if let block = self.configure?.completionBlock {
                block()
            }
        }
    }
}

extension ModalAnimator: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from) else { return }
        guard let toViewController = transitionContext.viewController(forKey: .to) else { return }

        let containerView = transitionContext.containerView
        let fromView = transitionContext.view(forKey: .from) ?? fromViewController.view!
        let toView = transitionContext.view(forKey: .to) ?? toViewController.view!

        fromView.frame = transitionContext.initialFrame(for: fromViewController)
        toView.frame = transitionContext.finalFrame(for: toViewController)

        let animationDuration = transitionDuration(using: transitionContext)
        let configure = AnimatorConfigure(from: fromView, to: toView, duration: animationDuration) {
            transitionContext.completeTransition(true)
        }
        
        
        switch presentationType {
        case .presented:
            containerView.addSubview(toView)
            animator(configure)
        case .dismiss:
            animator(configure)
        }
    }
}

extension ModalAnimator: UIViewControllerInteractiveTransitioning {
    func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        
    }
}

