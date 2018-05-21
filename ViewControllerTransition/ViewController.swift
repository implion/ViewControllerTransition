//
//  ViewController.swift
//  ViewControllerTransition
//
//  Created by 文圣灵 on 2018/5/17.
//  Copyright © 2018年 ShengLing. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var tableView: UITableView!
    
    var titles: [String] = ["alpha transition"] {
        didSet {
            dataSource.dataSource = titles
            tableView.reloadData()
        }
    }
    
    lazy var dataSource: TableViewDataSource = {
        return TableViewDataSource(titles, reuseIdentifier: "\(TitleCell.self)", action: { [weak self] (cell: UITableViewCell?, indexPath: IndexPath) in
            guard let strongSelf = self else { return }
            cell?.textLabel?.text = strongSelf.titles[indexPath.row]
        })
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureTableView()
    }

    func configureTableView() {
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.register(TitleCell.self, forCellReuseIdentifier: "\(TitleCell.self)")
        view.addSubview(tableView)
    }

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            let controller = AlphaAnimatorViewController()
            controller.modalPresentationStyle = .custom
            controller.transitioningDelegate = self
            present(controller, animated: true, completion: nil)
        default:
            break
        }
    }
}


extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = BaseAnimator()
        animator.isPresented = true
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BaseAnimator()
    }
}