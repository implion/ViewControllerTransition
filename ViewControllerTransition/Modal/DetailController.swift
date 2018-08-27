//
//  DetailController.swift
//  ViewControllerTransition
//
//  Created by implion on 2018/8/17.
//  Copyright © 2018年 ShengLing. All rights reserved.
//

import UIKit

class DetailController: UIPresentationController {
    
    let detailView = UIView()
    var visualView = UIVisualEffectView()
    
    let topMargin: CGFloat = 40.0
    
    override func presentationTransitionWillBegin() {
        
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.visualView.alpha = 0.3
        }, completion: nil)
    }
    
    override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.visualView.alpha = 0.0
        }, completion: nil)
    }
    
    
    override func containerViewWillLayoutSubviews() {
        let blurEffect = UIBlurEffect(style: .dark)
        visualView = UIVisualEffectView(effect: blurEffect)
        visualView.frame = self.containerView!.bounds
        self.containerView?.addSubview(visualView)
        
        visualView.contentView.addSubview(detailView)
        let height = containerView!.bounds.height - topMargin
        let width = containerView!.bounds.width
        let originPoint = CGPoint(x: 0, y: containerView!.bounds.height)
        detailView.frame = CGRect(origin: originPoint, size: CGSize(width: width, height: height))

        let bounds = CGRect(x: 0, y: 0, width: containerView!.bounds.width, height: containerView!.bounds.height - topMargin)
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [UIRectCorner.topLeft, UIRectCorner.topRight], cornerRadii: CGSize(width: 10, height: 10))
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.frame = bounds
        detailView.layer.mask = shapeLayer
        detailView.backgroundColor = .white

    }
    
    override func containerViewDidLayoutSubviews() {
        let height = containerView!.bounds.height - topMargin
        let width = containerView!.bounds.width
        KeyframeAnimation.default.create(detailView.layer, values: [Float(detailView.layer.position.y), Float(height / 2 + 40)], timeingFuntion: .bounceEaseOut)
//        let keyframeAniamtion = CAKeyframeAnimation(keyPath: "position.y")
//        keyframeAniamtion.duration = 0.5
//        keyframeAniamtion.values = [NSNumber(value: Float(detailView.layer.position.y)), NSNumber(value: 40 + Float(height / 2))]
//        keyframeAniamtion.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
//        let springAnimation = CASpringAnimation(keyPath: "position.y")
//        springAnimation.mass = 0.25
//        springAnimation.stiffness = 50
//        springAnimation.damping = 5
//        springAnimation.initialVelocity = 10
//        springAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
//        springAnimation.fromValue = NSNumber(value: Float(detailView.layer.position.y))
//        springAnimation.toValue = NSNumber(value: 40 + Float(height / 2))
//        springAnimation.duration = 1
//        detailView.layer.add(keyframeAniamtion, forKey: "position.y")
        detailView.frame = CGRect(origin: CGPoint(x: 0, y: topMargin), size: CGSize(width: width, height: height))
    }
    
}


