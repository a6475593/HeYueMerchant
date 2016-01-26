//
//  DesignableTextField.swift
//  HeYueMerchant
//
//  Created by 王玉琨 on 15/12/28.
//  Copyright © 2015年 王玉琨. All rights reserved.
//

import UIKit

@IBDesignable internal class DesignableTextField: UITextField {

    
    @IBInspectable internal var placeholderColor: UIColor = UIColor.clearColor() {
        didSet {
            attributedPlaceholder = NSAttributedString(string: placeholder!, attributes: [NSForegroundColorAttributeName: placeholderColor])
            layoutSubviews()
            
        }
    }
    
    @IBInspectable internal var sidePadding: CGFloat = 0 {
        didSet {
            let padding = UIView(frame: CGRectMake(0, 0, sidePadding, sidePadding))
            
            leftViewMode = UITextFieldViewMode.Always
            leftView = padding
            
            rightViewMode = UITextFieldViewMode.Always
            rightView = padding
        }
    }
    
    @IBInspectable internal var leftPadding: CGFloat = 0 {
        didSet {
            let padding = UIView(frame: CGRectMake(0, 0, leftPadding, 0))
            
            leftViewMode = UITextFieldViewMode.Always
            leftView = padding
        }
    }
    
    @IBInspectable internal var rightPadding: CGFloat = 0 {
        didSet {
            let padding = UIView(frame: CGRectMake(0, 0, rightPadding, 0))
            
            rightViewMode = UITextFieldViewMode.Always
            rightView = padding
        }
    }
    
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
    
    @IBInspectable internal var lineHeight: CGFloat = 1.5 {
        didSet {
            let font = UIFont(name: self.font!.fontName, size: self.font!.pointSize)
            let text = self.text
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineHeight
            
            let attributedString = NSMutableAttributedString(string: text!)
            attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
            attributedString.addAttribute(NSFontAttributeName, value: font!, range: NSMakeRange(0, attributedString.length))
            
            self.attributedText = attributedString
        }
    }
    @IBInspectable internal var masksToBounds: Bool = false {
        didSet {
            layer.masksToBounds = masksToBounds
        }
    }
    

}
