//
//  OrderDetailsCell.swift
//  HeYueMerchant
//
//  Created by 王玉琨 on 16/3/5.
//  Copyright © 2016年 王玉琨. All rights reserved.
//

import UIKit

class OrderDetailsCell: UITableViewCell {
    @IBOutlet weak var First: UILabel!
    @IBOutlet weak var Second: UILabel!
    @IBOutlet weak var Third: UILabel!
    @IBOutlet weak var Fourth: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
