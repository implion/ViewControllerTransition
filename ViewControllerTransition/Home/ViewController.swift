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
    var button: UIButton!
    
    var titles: [String] = ["alpha transition", "Apple Music"] {
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
        title = "list"
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().backgroundColor = .white
        self.navigationController?.navigationBar.barTintColor = .white
        configureTableView()
        configureButton()
    }

    func configureTableView() {
        
        var frame = view.bounds
        frame.origin.y += 64
        tableView = UITableView(frame: frame, style: .plain)
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.clipsToBounds = true
        tableView.register(TitleCell.self, forCellReuseIdentifier: "\(TitleCell.self)")
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        }
    }
    
    func configureButton() {
        button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        button.backgroundColor = .red
        button.frame = CGRect(x: (view.bounds.width - 66) / 2, y: view.bounds.height - 66, width: 66, height: 66)
        button.addTarget(self, action: #selector(maskTransition), for: .touchUpInside)
        button.layer.cornerRadius = 33
        view.addSubview(button)
    }

    @objc func maskTransition() {
        let transition = MaskTransition(button)
        let controller = MaskViewController()
        self.navigationController?.delegate = transition
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            let transition = ModalTransition()
            self.transitioningDelegate = transition
            let controller = AlphaAnimatorViewController()
//            controller.modalPresentationStyle = .fullScreen
            controller.modalPresentationStyle = .custom
            controller.transitioningDelegate = transition
            present(controller, animated: true, completion: nil)
        case 1:
            let transition = ModalTransition()
            self.transitioningDelegate = transition
            let controller = AppleMusicController()
            controller.modalPresentationStyle = .custom
            controller.transitioningDelegate = transition
            controller.transition = transition
            present(controller, animated: true, completion: nil)
        default:
            break
        }
    }
}

