//
//  ModalTransition.swift
//  ViewControllerTransition
//
//  Created by implion on 2018/8/27.
//  Copyright © 2018年 ShengLing. All rights reserved.
//

import UIKit

class ModalTransition: NSObject {
    let presentingScalaFactor: CGFloat = 0.9
    let presentedOffsetY: CGFloat = 60
    var isPresenting = true
    var transitionContext: UIViewControllerContextTransitioning?
    
    func addPanGestureRecognizer(_ view: UIView) {
        view.isUserInteractionEnabled = true
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panAction(_:)))
        view.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc func panAction(_ sender: UIPanGestureRecognizer) {
        guard let view = sender.view else { return }
        guard let transitionContext = transitionContext else { return }
        let translate = sender.translation(in: view).y
        let velocity = sender.velocity(in: view).y
        let factor = translate / view.bounds.height
        let scalaFactor = presentingScalaFactor + (1 - presentingScalaFactor) * factor
        let presentingView = transitionContext.viewController(forKey: .from)?.view
        switch sender.state {
        case .began:
            sender.setTranslation(.zero, in: view)
            print("pan began")
        case .ended, .cancelled:
            var shouldFinish = false
            let duration: CGFloat = 0.2
            shouldFinish = (0.1 * velocity + translate) >= view.bounds.height / 2
            UIView.animate(withDuration: Double(duration), animations: {
                if shouldFinish {
                    view.frame = CGRect(x: 0, y: view.bounds.height, width: view.bounds.width, height: view.bounds.height)
                    presentingView?.transform = CGAffineTransform(scaleX: 1, y: 1)
                } else {
                    view.frame = CGRect(x: 0, y: self.presentedOffsetY, width: view.bounds.width, height: view.bounds.height)
                    presentingView?.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                }
            }, completion: { _ in
                if shouldFinish {
                    transitionContext.viewController(forKey: .to)?.dismiss(animated: false, completion: nil)
                }
            })
            
        case .changed:
            if translate > 0 {
                var finalFrame = transitionContext.view(forKey: .to)!.frame
                finalFrame.origin.y = translate + presentedOffsetY
                view.frame = finalFrame
                presentingView?.transform = CGAffineTransform(scaleX: scalaFactor, y: scalaFactor)
            }
        default:
            break
        }
    }
}

extension ModalTransition: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        guard let fromViewController = transitionContext.viewController(forKey: .from) else { return }
        guard let toViewController = transitionContext.viewController(forKey: .to) else { return }
        
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to) ?? toViewController.view!
        var finalFrame = transitionContext.finalFrame(for: toViewController)
        
        let scalaFactor = presentingScalaFactor
        
        var presentedViewController = toViewController
        var presentingViewController = fromViewController
        
        let duration = transitionDuration(using: transitionContext)
        
        var transformScala = CGAffineTransform(scaleX: scalaFactor, y: scalaFactor)
        if isPresenting {
            transformScala = CGAffineTransform(scaleX: scalaFactor, y: scalaFactor)
            finalFrame = transitionContext.finalFrame(for: toViewController)
            finalFrame.origin.y += presentedOffsetY
            toView.frame = CGRect(x: 0, y: finalFrame.height, width: finalFrame.width, height: finalFrame.height)
            containerView.addSubview(toView)
            presentingViewController = fromViewController
            presentedViewController = toViewController
        } else {
            finalFrame = CGRect(x: 0, y: finalFrame.height, width: finalFrame.width, height: finalFrame.height)
            transformScala = CGAffineTransform.identity
            presentingViewController = toViewController
            presentedViewController = fromViewController
        }
        
        UIView.animate(withDuration: duration,
                       delay: 0.0,
                       usingSpringWithDamping: 100,
                       initialSpringVelocity: 10,
                       options: .allowUserInteraction,
                       animations: {
                        presentingViewController.view.transform = transformScala
                        presentedViewController.view.frame = finalFrame
                        if !self.isPresenting {
                            presentingViewController.view.transform = CGAffineTransform.identity
                            presentingViewController.view.frame = transitionContext.finalFrame(for: toViewController)
                        }
        }, completion: { _ in
            transitionContext.completeTransition(true)
        })
    }
}


extension ModalTransition: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.isPresenting = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.isPresenting = false
        return self
    }
}
