//
//  OrderList.swift
//  ViewControllerTransition
//
//  Created by implion on 2018/8/29.
//  Copyright © 2018年 ShengLing. All rights reserved.
//

import UIKit

class OrderListController: UIViewController {

    var tableView: UITableView!
    
    var dataSource: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.dataSource = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
        self.tableView.reloadData()
        for (i, cell) in tableView.visibleCells.enumerated() {
            cell.alpha = 0
            cell.transform = CGAffineTransform(translationX: 0, y: -20)
            UIView.animate(withDuration: 0.3, delay: Double(i) * 0.05, options: UIViewAnimationOptions.curveEaseOut, animations: {
                cell.alpha = 1.0
                cell.transform = CGAffineTransform.identity
            }, completion: { _ in
                
            })
        }
    }

    func configureTableView() {
        var frame = view.bounds
        frame.origin.y += 64
        frame.size.height -= 64
        tableView = UITableView(frame: frame, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.clipsToBounds = true
        tableView.register(UINib(nibName: "\(OrderCell.self)", bundle: nil), forCellReuseIdentifier: "\(OrderCell.self)")
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.rowHeight = 121
        view.addSubview(tableView)
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        }
    }

}

extension OrderListController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let orderCell = tableView.dequeueReusableCell(withIdentifier: "\(OrderCell.self)") as? OrderCell
        orderCell?.layer.cornerRadius = 8.0
        orderCell?.selectionStyle = .none
//        orderCell?.numberLabel.text = "\(dataSource[indexPath.section])"
        return orderCell!
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
}

extension OrderListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? OrderCell else { return }
        let transition = MaskTransition(cell.backgroundColorView, shape: .square)
        let controller = OrderDetailController()
        navigationController?.delegate = transition
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
