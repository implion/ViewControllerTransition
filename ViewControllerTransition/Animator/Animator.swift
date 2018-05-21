//
//  Animator.swift
//  ViewControllerTransition
//
//  Created by 文圣灵 on 2018/5/17.
//  Copyright © 2018年 ShengLing. All rights reserved.
//

import Foundation
import UIKit

protocol Animator: UIViewControllerAnimatedTransitioning {
    var animationDuration: TimeInterval { get }
    
}

extension Animator {
    var animationDuration: TimeInterval { return 0.0 } 
}
