//
//  SelectShop.swift
//  HeYueMerchant
//
//  Created by 王玉琨 on 16/2/27.
//  Copyright © 2016年 王玉琨. All rights reserved.
//

import UIKit

protocol showRMPickView {
    func showRMPickViewController()
}

class SelectShop: UIView {

    @IBOutlet weak var SelectShopBT: UIButton!
    @IBOutlet weak var SelectShopTF: DesignableTextField!
   var delegate : showRMPickView?
    
    override func drawRect(rect: CGRect) {
        // Drawing code
        SelectShopBT.addTarget(self, action: "showRMPcikViewAction", forControlEvents: .TouchUpInside)
        
    }
    func showRMPcikViewAction(){
    self.delegate?.showRMPickViewController()
    }
    
}






















