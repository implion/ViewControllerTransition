//
//  AlphaAnimatorViewController.swift
//  ViewControllerTransition
//
//  Created by shengling on 2018/5/19.
//  Copyright © 2018年 ShengLing. All rights reserved.
//

import UIKit

class AlphaAnimatorViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    var button: UIButton = UIButton(type: .custom)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        configureView()
        
        
        // Do any additional setup after loading the view.
    }

    func configureView() {
        button.setTitle("dismiss", for: .normal)
        button.frame = CGRect(x: (UIScreen.main.bounds.width - 60) / 2, y: (UIScreen.main.bounds.height - 40) / 2, width: 60, height: 40)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .green
        button.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc func dismissAction() {
        dismiss(animated: true, completion: nil)
    }

}
