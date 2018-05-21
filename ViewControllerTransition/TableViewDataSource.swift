//
//  DataSource.swift
//  ViewControllerTransition
//
//  Created by shengling on 2018/5/18.
//  Copyright © 2018年 ShengLing. All rights reserved.
//

import Foundation
import UIKit

final class TableViewDataSource: NSObject {
    
    var dataSource: [Any] = []
    var reuseIdentifier: String = ""
    var cellAction: ((UITableViewCell?, IndexPath) -> ())?
    init<T>(_ dataSource: [T], reuseIdentifier: String, action: @escaping (UITableViewCell?, IndexPath) -> ()) {
        self.dataSource = dataSource
        self.reuseIdentifier = reuseIdentifier
        self.cellAction = action
    }
}


extension TableViewDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
        if let action = cellAction {
            action(cell, indexPath)
        }
        return cell!
    }
}
