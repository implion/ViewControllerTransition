//
//  UIView+Appearce.swift
//  ViewControllerTransition
//
//  Created by implion on 2018/8/30.
//  Copyright © 2018年 ShengLing. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func corner(_ radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: radius))
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = bounds
        shapeLayer.path = path.cgPath
        layer.mask = shapeLayer
    }
    
    func shadow() {
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 5
    }
    
}
