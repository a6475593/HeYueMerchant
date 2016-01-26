//
//  Goods.swift
//  HeYueMerchant
//
//  Created by 王玉琨 on 16/1/4.
//  Copyright © 2016年 王玉琨. All rights reserved.
//

import UIKit

class Goods: UITableViewCell {

    @IBOutlet weak var goodsImage: UIImageView!

    @IBOutlet weak var goodsname: UILabel!
  
    @IBOutlet weak var prices: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
