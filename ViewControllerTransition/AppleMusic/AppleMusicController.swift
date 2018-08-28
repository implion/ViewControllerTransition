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
        let height = UIScreen.main.bounds.height
        barView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 44))
        barView.backgroundColor = .orange
        view.addSubview(barView)
        transition.addPanGestureRecognizer(view)
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: (width - 100) / 2, y: (height - 44) / 2, width: 100, height: 44)
        button.setTitle("dismiss", for: .normal)
        button.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
        button.backgroundColor = .orange
        view.addSubview(button)
    }
    
    @objc func dismissAction() {
        self.dismiss(animated: true, completion: nil)
    }
    

}
