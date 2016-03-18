//
//  SearchInformationVC.swift
//  HeYueMerchant
//
//  Created by 王玉琨 on 16/1/22.
//  Copyright © 2016年 王玉琨. All rights reserved.
//

import UIKit

class SearchInformationVC: BaseViewController,UIPickerViewDelegate,UIPickerViewDataSource{
    
    @IBOutlet weak var startTimeTextField: DesignableTextField!
    
    @IBOutlet weak var finishTimeTextField: DesignableTextField!
    
    @IBOutlet weak var orderStatusTextField: DesignableTextField!
    
    
    
    var years = NSMutableArray()
    var days = NSMutableArray()
    let months = ["1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月"]
    let orderstatus = ["下单失败","等待验证","交易过期","支付失败","支付成功"]
    
    var StartPickerController = RMPickerViewController()
    var FinishPickerController = RMPickerViewController()
    var OrderStatusController = RMPickerViewController()
    let style = RMActionControllerStyle.White
    
    var IsLeapYear = false
    var IsFebruary = false
    var IsBigMonth = false
    var IsSmallMonth = false
    var IsNoLessThanTwentyEight = false
    var IsNoLessThanTwentyNine = false
    var IsNoLessThanThirty = false
    var IsNoLessThanThirtyOne = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let Search = UIBarButtonItem(title: "搜索", style: UIBarButtonItemStyle.Done, target: self, action: #selector(SearchInformationVC.Search))
        self.navigationItem.rightBarButtonItem = Search
        
        let year = Int(NSString(string: String(NSDate())).substringWithRange(NSMakeRange(0, 4)))!
        if year%4 == 0{
            IsLeapYear = true
        }
        let month = Int(NSString(string: String(NSDate())).substringWithRange(NSMakeRange(5, 2)))!
        if month == 2{
            IsFebruary = true
        }
        if month == 1||month == 3||month == 5||month == 7||month == 8||month == 10||month == 12{
            IsBigMonth = true
        }
        if month == 4||month == 6||month == 9||month == 11{
            IsSmallMonth = true
        }
        let day = Int(NSString(string: String(NSDate())).substringWithRange(NSMakeRange(8, 2)))!
        if 28 <= day && day < 29{
            IsNoLessThanTwentyEight = true
        }else if 29 <= day && day < 30{
            IsNoLessThanTwentyNine = true
        }else if 30 <= day && day < 31{
            IsNoLessThanThirty = true
        }else if 31 <= day{
            IsNoLessThanThirtyOne = true
        }
        
        for i in 2000 ..< 2101 {
            years.addObject("\(i)年")
        }
        for i in 1 ..< 32 {
            days.addObject("\(i)日")
        }
    }
    func Search(){
        print("完成")
        self.navigationController?.popViewControllerAnimated(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func showstartaction(sender: AnyObject) {
        StartPickerController = RMPickerViewController.init(style: style)!
        let selectAction = RMAction.init(title: "确定", style: .Destructive) { (controller:RMActionController) -> Void in
            let selectRows = NSMutableArray()
            let picker = (controller as! RMPickerViewController).picker
            for i in 0 ..< picker.numberOfComponents {
                selectRows.addObject(picker.selectedRowInComponent(i))
            }
            var Date = String()
            let Year = (self.years[(selectRows[0] as! Int)] as! NSString).substringWithRange(NSMakeRange(0, 4))
            var Month = String()
            var Day = String()
            let month = self.months[selectRows[1] as! Int] as NSString
            if month.length == 2{
                Month = month.substringWithRange(NSMakeRange(0, 1))
            }else if month.length == 3{
                Month = month.substringWithRange(NSMakeRange(0, 2))
            }
            let day = self.days[selectRows[2] as! Int] as! NSString
            if day.length == 2{
                Day = day.substringWithRange(NSMakeRange(0, 1))
            }else if day.length == 3{
                Day = day.substringWithRange(NSMakeRange(0, 2))
            }
            
            Date = (Year.stringByAppendingString("-\(Month)")).stringByAppendingString("-\(Day)")
            self.startTimeTextField.text = Date
            }!
        let cancelAction = RMAction.init(title: "取消", style: .Done, andHandler: nil)!
        let clearlAction = RMAction.init(title: "清空", style: .Cancel) { (controller:RMActionController) -> Void in
            self.startTimeTextField.text = ""
            }!
        StartPickerController.title = "请选择开始日期"
        StartPickerController.addAction(clearlAction)
        StartPickerController.addAction(cancelAction)
        StartPickerController.addAction(selectAction)
        StartPickerController.picker.delegate = self
        StartPickerController.picker.dataSource = self
        StartPickerController.disableBlurEffects = true
        StartPickerController.disableBouncingEffects = true
        setCalendar(StartPickerController)
        self.presentViewController(StartPickerController, animated: true, completion: nil)
    }
    
    
    @IBAction func finishTimeAction(sender: AnyObject) {
        FinishPickerController = RMPickerViewController.init(style: style)!
        let selectAction = RMAction.init(title: "确定", style: .Destructive) { (controller:RMActionController) -> Void in
            let selectRows = NSMutableArray()
            let picker = (controller as! RMPickerViewController).picker
            for i in 0 ..< picker.numberOfComponents {
                selectRows.addObject(picker.selectedRowInComponent(i))
            }
            var Date = String()
            let Year =  (self.years[(selectRows[0] as! Int)] as! NSString).substringWithRange(NSMakeRange(0, 4))
            var Month = String()
            var Day = String()
            let month = self.months[selectRows[1] as! Int] as NSString
            if month.length == 2{
                Month = month.substringWithRange(NSMakeRange(0, 1))
            }else if month.length == 3{
                Month = month.substringWithRange(NSMakeRange(0, 2))
            }
            let day = self.days[selectRows[2] as! Int] as! NSString
            if day.length == 2{
                Day = day.substringWithRange(NSMakeRange(0, 1))
            }else if day.length == 3{
                Day = day.substringWithRange(NSMakeRange(0, 2))
            }
            
            Date = (Year.stringByAppendingString("-\(Month)")).stringByAppendingString("-\(Day)")
            self.finishTimeTextField.text = Date
            }!
        let cancelAction = RMAction.init(title: "取消", style: .Done, andHandler: nil)!
        let clearlAction = RMAction.init(title: "清空", style: .Cancel) { (controller:RMActionController) -> Void in
            self.finishTimeTextField.text = ""
            }!
        FinishPickerController.title = "请选择结束日期"
        FinishPickerController.addAction(clearlAction)
        FinishPickerController.addAction(cancelAction)
        FinishPickerController.addAction(selectAction)
        FinishPickerController.picker.delegate = self
        FinishPickerController.picker.dataSource = self
        FinishPickerController.disableBlurEffects = true
        FinishPickerController.disableBouncingEffects = true
        setCalendar(FinishPickerController)
        self.presentViewController(FinishPickerController, animated: true, completion: nil)
    }
    
    @IBAction func orderStatusAction(sender: AnyObject) {
        OrderStatusController = RMPickerViewController.init(style: style)!
        
        let selectAction = RMAction.init(title: "确定", style: .Destructive) { (controller:RMActionController) -> Void in
            let picker = (controller as! RMPickerViewController).picker
            var selectString = String()
            for i in 0 ..< picker.numberOfComponents {
                selectString = self.orderstatus[picker.selectedRowInComponent(i)]
            }
            self.orderStatusTextField.text = selectString
            }!
        let cancelAction = RMAction.init(title: "取消", style: .Done, andHandler: nil)!
        let clearlAction = RMAction.init(title: "清空", style: .Cancel) { (controller:RMActionController) -> Void in
            self.orderStatusTextField.text = ""
            }!
        OrderStatusController.title = "请选择结束日期"
        OrderStatusController.addAction(clearlAction)
        OrderStatusController.addAction(cancelAction)
        OrderStatusController.addAction(selectAction)
        OrderStatusController.picker.delegate = self
        OrderStatusController.picker.dataSource = self
        OrderStatusController.disableBlurEffects = true
        OrderStatusController.disableBouncingEffects = true
        OrderStatusController.picker.selectRow(0, inComponent: 0, animated: true)
        self.presentViewController(OrderStatusController, animated: true, completion: nil)
        
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        if pickerView == OrderStatusController.contentView {
            return 1
        }
        if pickerView == StartPickerController.contentView || pickerView == FinishPickerController.contentView{
            return 3
        }
        return 0
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == StartPickerController.contentView || pickerView == FinishPickerController.contentView{
            if component == 0 {
                return years.count
            }else if component == 1{
                return months.count
            }else if component == 2{
                return days.count
            }
        }
        if pickerView == OrderStatusController.contentView{
            return orderstatus.count
        }
        return 0
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == StartPickerController.contentView || pickerView == FinishPickerController.contentView{
            if component == 0 {
                return years[row] as? String
            }else if component == 1{
                return months[row]
            }else if component == 2{
                return days[row] as? String
            }
        }
        if pickerView == OrderStatusController.contentView{
            return orderstatus[row]
        }
        return nil
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == StartPickerController.contentView || pickerView == FinishPickerController.contentView{
               if component == 0{//年
                if row%4 == 0{
                    IsLeapYear = true
                }else{
                    IsLeapYear = false
                }
                
                if IsFebruary && IsNoLessThanTwentyNine && row%4 != 0{//平年
                    pickerView.selectRow(27, inComponent: 2, animated: true)//设置28号
                    IsNoLessThanTwentyEight = true
                    IsNoLessThanTwentyNine = false
                    IsNoLessThanThirty = false
                    IsNoLessThanThirtyOne = false
                }
                
                if IsFebruary && IsNoLessThanThirty && row%4 == 0{//闰年
                    pickerView.selectRow(28, inComponent: 2, animated: true)//设29号
                    IsNoLessThanTwentyEight = true
                    IsNoLessThanTwentyNine = true
                    IsNoLessThanThirty = false
                    IsNoLessThanThirtyOne = false
                }
            }
            
            if component == 1{//月
                if row == 1{//是不是2月
                    IsFebruary = true
                }else{
                    IsFebruary = false
                }
                if row == 0||row == 2||row == 4||row == 6||row == 7||row == 9||row == 11{//是不是大月
                    IsBigMonth = true
                }else{
                    IsBigMonth = false
                }
                if row == 3||row == 5||row == 8||row == 10{//是不是小月
                    IsSmallMonth = true
                }else{
                    IsSmallMonth = false
                }
                
                if IsLeapYear && IsNoLessThanThirty && row == 1 {//30号以上
                    pickerView.selectRow(28, inComponent: 2, animated: true)
                    IsNoLessThanTwentyEight = true
                    IsNoLessThanTwentyNine = true
                    IsNoLessThanThirty = false
                    IsNoLessThanThirtyOne = false
                }
                if IsLeapYear == false && IsNoLessThanTwentyNine && row == 1{//29号以上
                    pickerView.selectRow(27, inComponent: 2, animated: true)
                    IsNoLessThanTwentyEight = true
                    IsNoLessThanTwentyNine = false
                    IsNoLessThanThirty = false
                    IsNoLessThanThirtyOne = false
                }
                if row == 3||row == 5||row == 8||row == 10{
                    if IsNoLessThanThirtyOne{
                        pickerView.selectRow(29, inComponent: 2, animated: true)
                        IsNoLessThanTwentyEight = true
                        IsNoLessThanTwentyNine = true
                        IsNoLessThanThirty = true
                        IsNoLessThanThirtyOne = false
                    }
                }
            }
            
            if component == 2{//日
                if  27 <= row && row < 28{//28号
                    IsNoLessThanTwentyEight = true
                    IsNoLessThanTwentyNine = false
                    IsNoLessThanThirty = false
                    IsNoLessThanThirtyOne = false
                }else if  28 <= row && row < 29{//29号
                    IsNoLessThanTwentyEight = true
                    IsNoLessThanTwentyNine = true
                    IsNoLessThanThirty = false
                    IsNoLessThanThirtyOne = false
                }else if 29 <= row && row < 30{//30号
                    IsNoLessThanTwentyEight = true
                    IsNoLessThanTwentyNine = true
                    IsNoLessThanThirty = true
                    IsNoLessThanThirtyOne = false
                }else if 30 <= row {//31号
                    IsNoLessThanTwentyEight = true
                    IsNoLessThanTwentyNine = true
                    IsNoLessThanThirty = true
                    IsNoLessThanThirtyOne = true
                }
                
                if IsLeapYear == false && IsFebruary && row >= 28 {//29号
                    pickerView.selectRow(27, inComponent: 2, animated: true)//设为28号
                    IsNoLessThanTwentyEight = true
                    IsNoLessThanTwentyNine = false
                    IsNoLessThanThirty = false
                    IsNoLessThanThirtyOne = false
                }
                
                if IsLeapYear && IsFebruary && row >= 29 {//30号
                    pickerView.selectRow(28, inComponent: 2, animated: true)//设为29号
                    IsNoLessThanTwentyEight = true
                    IsNoLessThanTwentyNine = true
                    IsNoLessThanThirty = false
                    IsNoLessThanThirtyOne = false
                    
                }
                if IsBigMonth && row >= 30 {//31号
                    return
                }
                if IsSmallMonth && row >= 30 {
                    pickerView.selectRow(29, inComponent: 2, animated: true)//设为30号
                    IsNoLessThanTwentyEight = true
                    IsNoLessThanTwentyNine = true
                    IsNoLessThanThirty = true
                    IsNoLessThanThirtyOne = false
                }
            }
        }
    }
    func setCalendar(picker:RMPickerViewController){
        for i in 2000 ..< 2101 {
            let year = NSString(string: String(NSDate())).substringWithRange(NSMakeRange(0, 4))
            if String(i) == year {
                picker.picker.selectRow(i-2000, inComponent: 0, animated: true)
            }
        }
        
        for i in 0 ..< 12 {
            let month = Int(NSString(string: String(NSDate())).substringWithRange(NSMakeRange(5, 2)))!
            if i == month{
                picker.picker.selectRow(i-1, inComponent: 1, animated: true)
            }
        }
        
        for i in 0 ..< 31 {
            let day = NSString(string: String(NSDate())).substringWithRange(NSMakeRange(8, 2))
            if String(i) == day{
                picker.picker.selectRow(i-1, inComponent: 2, animated: true)
            }
        }
    }
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    
    
}
