//
//  UserConstants.swift
//  HeYueMerchant
//
//  Created by 王玉琨 on 15/12/28.
//  Copyright © 2015年 王玉琨. All rights reserved.
//

import UIKit

class Define:NSObject {
    
    class func ifIOS7()->Bool{
        let t =  UIDevice.currentDevice()
        let v = t.systemVersion
        let arr:NSArray = v.componentsSeparatedByString(".")
        let num : AnyObject! = arr[0]
        let Num:CInt = num.intValue
        if Num >= 7 {
            return true
        }else{
            return false
        }
    }
    class func ifIOS8()->Bool{
        let t =  UIDevice.currentDevice()
        let v = t.systemVersion
        let arr:NSArray = v.componentsSeparatedByString(".")
        let num : AnyObject! = arr[0]
        let Num:CInt = num.intValue
        if Num >= 8 {
            return true
        }else{
            return false
        }
    }
    class  func screenHeight()->CGFloat {
        let main = UIScreen.mainScreen()
        let rect = main.bounds
        let height = rect.height
        return height
    }
    class  func screenWidth()->CGFloat {
        let main = UIScreen.mainScreen()
        let rect = main.bounds
        let width = rect.width
        return width
    }
}