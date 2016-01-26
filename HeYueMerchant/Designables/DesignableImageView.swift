//
//  DesignableImageView.swift
//  HeYueMerchant
//
//  Created by 王玉琨 on 15/12/30.
//  Copyright © 2015年 王玉琨. All rights reserved.
//

import UIKit

@IBDesignable internal class DesignableImageView: UIImageView {

    @IBInspectable internal var borderColor: UIColor = UIColor.clearColor() {
        didSet {
            layer.borderColor = borderColor.CGColor
        }
    }
    
    @IBInspectable internal var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable internal var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    

    @IBInspectable internal var masksToBounds: Bool = false {
        didSet {
            layer.masksToBounds = masksToBounds
        }
    }


}
