//
//  MaskTransition.swift
//  ViewControllerTransition
//
//  Created by implion on 2018/8/28.
//  Copyright © 2018年 ShengLing. All rights reserved.
//

import Foundation
import UIKit


class MaskTransition: NSObject {
    
    enum Shape {
        case circle
        case square
    }
    
    var operation: UINavigationControllerOperation = .push
    var transitionContext: UIViewControllerContextTransitioning?
    let maskView: UIView
    let shape: Shape
    init(_ mask: UIView, shape: Shape) {
        maskView = mask
        self.shape = shape
    }
}

extension MaskTransition: UIViewControllerAnimatedTransitioning {
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        guard let fromViewController = transitionContext.viewController(forKey: .from) else { return }
        guard let toViewController = transitionContext.viewController(forKey: .to) else { return }
        
        let containerView = transitionContext.containerView
        let fromView = transitionContext.view(forKey: .from) ?? fromViewController.view!
        let toView = transitionContext.view(forKey: .to) ?? toViewController.view!
        
        let duration = transitionDuration(using: transitionContext)
        containerView.addSubview(fromView)
        containerView.addSubview(toView)

        var endPoint = CGPoint(x: 0, y: 0)
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        if maskView.frame.origin.x > width / 2 && maskView.frame.origin.y > height / 2 {
            endPoint = CGPoint(x: 0, y: 0)
        } else if maskView.frame.origin.x > width / 2 {
            endPoint = CGPoint(x: 0, y: height)
        } else if maskView.frame.origin.y > height / 2 {
            endPoint = CGPoint(x: width, y: 0)
        } else {
            endPoint = CGPoint(x: width, y: height)
        }
        
        let radius = sqrt(pow(endPoint.x - maskView.center.x, 2) + pow(endPoint.y - maskView.center.y, 2))
        
        let fromeRect = maskView.convert(maskView.bounds, to: nil)
        let fromPath = shape == .circle ? UIBezierPath(ovalIn: fromeRect) : UIBezierPath(roundedRect: fromeRect, cornerRadius: 12)
        let factor = toView.bounds.height / fromeRect.height
        let toPath = shape == .circle ? UIBezierPath(ovalIn: fromeRect.insetBy(dx: -radius, dy: -radius)) : UIBezierPath(roundedRect: toView.frame, cornerRadius: 12 * factor)
        let layer = CAShapeLayer()
        layer.path = toPath.cgPath
        toViewController.view.layer.mask = layer
        
        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.fromValue = fromPath.cgPath
        pathAnimation.toValue = toPath.cgPath
        pathAnimation.duration = duration
        pathAnimation.delegate = self
        pathAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        layer.add(pathAnimation, forKey: "path")
        
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
}

extension MaskTransition: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            transitionContext?.completeTransition(true)
            transitionContext?.viewController(forKey: .to)?.view.layer.mask = nil
            transitionContext?.viewController(forKey: .from)?.view.layer.mask = nil
        }
    }
}


extension MaskTransition: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.operation = operation
        return self
    }
}
