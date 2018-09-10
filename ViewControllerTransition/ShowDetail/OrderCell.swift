//
//  OrderCell.swift
//  ViewControllerTransition
//
//  Created by implion on 2018/8/29.
//  Copyright © 2018年 ShengLing. All rights reserved.
//

import UIKit

class OrderCell: UITableViewCell {

    @IBOutlet weak var backgroundColorView: UIView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var numberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColorView.layoutIfNeeded()
        shadowView.layoutIfNeeded()
        backgroundColorView.corner(6)
        shadowView.shadow()

    }
    
}
