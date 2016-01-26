//
//  CheckTextField.swift
//  HeYueMerchant
//
//  Created by 王玉琨 on 16/1/5.
//  Copyright © 2016年 王玉琨. All rights reserved.
//

import Foundation

func isNumber(number:String)->Bool{
    let x = "^\\+?[1-9][0-9]*$"
    let regextestnumber = NSPredicate(format:"SELF MATCHES %@",x)
    if regextestnumber.evaluateWithObject(number){
        return true
    }else{
        return false
    }
    
}

func isTelNumber(num:String)->Bool{
    let mobile = "^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$"
    let  CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
    let  CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
    let  CT = "^1((33|53|8[09])[0-9]|349)\\d{7}$"
    let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
    let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
    let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
    let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
    if ((regextestmobile.evaluateWithObject(num) == true)
        || (regextestcm.evaluateWithObject(num)  == true)
        || (regextestct.evaluateWithObject(num) == true)
        || (regextestcu.evaluateWithObject(num) == true))
    {
        return true
    }else{
        return false
    }
}