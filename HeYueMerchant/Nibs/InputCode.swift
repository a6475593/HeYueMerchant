//
//  InputCode.swift
//  HeYueMerchant
//
//  Created by 王玉琨 on 16/2/29.
//  Copyright © 2016年 王玉琨. All rights reserved.
//

import UIKit

protocol RegisterFirst{
    func RegisterFirstBT()
}

class InputCode: UIView {
    private let kLivelyBlueColor = UIColor(red: 3 / 255, green: 169 / 255, blue: 244 / 255, alpha: 1)
    
    var delegateRegisterFirst : RegisterFirst?
    @IBOutlet weak var InputCodeBT: UIButton!
    @IBOutlet weak var InputCodeTF: DesignableTextField!
    @IBOutlet weak var CodeTypeControl: SegmentedControl!
    
    override func drawRect(rect: CGRect) {
        InputCodeBT.addTarget(self, action: "InputCodeAction", forControlEvents: .TouchUpInside)
    }
    
    func InputCodeAction(){
        self.delegateRegisterFirst?.RegisterFirstBT()
    }
    
}

















