//
//  AppleMusicController.swift
//  ViewControllerTransition
//
//  Created by implion on 2018/8/27.
//  Copyright © 2018年 ShengLing. All rights reserved.
//

import UIKit

class AppleMusicController: UIViewController {

    var barView: UIView!
    var transition: ModalTransition!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.transitioningDelegate = transition
        view.backgroundColor = .white
        let width = UIScreen.main.bounds.width
//        let height = UIScreen.main.bounds.height
        barView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 44))
        barView.backgroundColor = .orange
        view.addSubview(barView)
        transition.addPanGestureRecognizer(view)
        // Do any additional setup after loading the view.
    }

}
