//
//  MyGoodsCell.swift
//  HeYueMerchant
//
//  Created by 王玉琨 on 16/3/1.
//  Copyright © 2016年 王玉琨. All rights reserved.
//

import UIKit

class MyGoodsCell: UITableViewCell {

    @IBOutlet weak var mygoodsImage: UIImageView!
    @IBOutlet weak var mygoodsnameLabel: UILabel!
    @IBOutlet weak var mygoodspriceLabel: UILabel!
    @IBOutlet weak var mygoodsstarttimeLabel: UILabel!
    @IBOutlet weak var mygoosendtimeLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
