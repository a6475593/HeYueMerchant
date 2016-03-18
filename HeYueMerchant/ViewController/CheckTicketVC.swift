//
//  CheckTicketVC.swift
//  HeYueMerchant
//
//  Created by 王玉琨 on 16/2/27.
//  Copyright © 2016年 王玉琨. All rights reserved.
//

import UIKit

class CheckTicketVC: BaseViewController,showRMPickView,RegisterFirst, SegmentedControlDelegate,UIPickerViewDelegate , UIPickerViewDataSource{
    
    var ShopsPickerController = RMPickerViewController()
    let style = RMActionControllerStyle.White
    var selectshopview : SelectShop!
    var inputcodeview : InputCode!
    let usertype = GetSetValue.integerForKey(USER_TYPE)
    private let kLivelyBlueColor = UIColor(red: 3 / 255, green: 169 / 255, blue: 244 / 255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "验证中心"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: self, action: nil)

        
        let selectshopnib = NSBundle.mainBundle().loadNibNamed("SelectShop", owner: self, options: nil)
        selectshopview = selectshopnib[0] as! SelectShop
      
        selectshopview.delegate = self
        let inputcodenib = NSBundle.mainBundle().loadNibNamed("InputCode", owner: self, options: nil)
        inputcodeview = inputcodenib[0] as! InputCode
        
        inputcodeview.delegateRegisterFirst = self
        configureSegmentedControl()
       
        
        if usertype == 1 {
            inputcodeview.frame = CGRectMake(0, (self.navigationController?.navigationBar.frame.height)! + ShareAPPlication.statusBarFrame.height , self.view.frame.width, 150)
        }else if usertype == 0{
            selectshopview.frame = CGRectMake(0, (self.navigationController?.navigationBar.frame.height)! + ShareAPPlication.statusBarFrame.height , self.view.frame.width , 60)
            inputcodeview.frame = CGRectMake(0, (self.navigationController?.navigationBar.frame.height)! + ShareAPPlication.statusBarFrame.height + 60, self.view.frame.width, 150)
        }
        
        self.view.addSubview(selectshopview)
        self.view.addSubview(inputcodeview)
        
    }
    
    func showRMPickViewController() {
        ShopsPickerController = RMPickerViewController.init(style: style)!
        let selectAction = RMAction.init(title: "确定", style: RMActionStyle.Destructive) { (controller:RMActionController) -> Void in
            
            let picker = (controller as! RMPickerViewController).picker
            var selectString = String()
            for i in 0 ..< picker.numberOfComponents {
                selectString = shops[picker.selectedRowInComponent(i)]
            }
            self.selectshopview.SelectShopTF.text = selectString
            }!
        let cancelAction = RMAction.init(title: "取消", style: .Done, andHandler: nil)!
        let clearlAction = RMAction.init(title: "清空", style: .Cancel) { (controller:RMActionController) -> Void in
            self.selectshopview.SelectShopTF.text = ""
            }!
        ShopsPickerController.addAction(selectAction)
        ShopsPickerController.addAction(cancelAction)
        ShopsPickerController.addAction(clearlAction)
        ShopsPickerController.picker.delegate = self
        ShopsPickerController.picker.dataSource = self
        ShopsPickerController.disableBlurEffects = true
        ShopsPickerController.disableBouncingEffects = true
        ShopsPickerController.picker.selectRow(0, inComponent: 0, animated: true)
        self.presentViewController(ShopsPickerController, animated: true, completion: nil)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        if pickerView == ShopsPickerController.contentView{
            return 1
        }
        return 0
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == ShopsPickerController.contentView{
            return shops.count
        }
        return 0
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == ShopsPickerController.contentView{
            return shops[row]
        }
        return nil
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == ShopsPickerController.contentView{
            print(shops[row])
        }
    }
    
    func RegisterFirstBT() {
        inputcodeview.InputCodeTF.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func configureSegmentedControl() {
        let titleStrings = ["1号券", "2号券", "3号券", "4号券", "5号券","6号券", "7号券", "8号券", "9号券", "10号券"]
        let titles: [NSAttributedString] = {
            let attributes = [NSFontAttributeName: UIFont.systemFontOfSize(14), NSForegroundColorAttributeName: UIColor.blackColor()]
            var titles = [NSAttributedString]()
            for titleString in titleStrings {
                let title = NSAttributedString(string: titleString, attributes: attributes)
                titles.append(title)
            }
            return titles
        }()
        let selectedTitles: [NSAttributedString] = {
            let attributes = [NSFontAttributeName: UIFont.systemFontOfSize(14), NSForegroundColorAttributeName: UIColor.whiteColor()]
            var selectedTitles = [NSAttributedString]()
            for titleString in titleStrings {
                let selectedTitle = NSAttributedString(string: titleString, attributes: attributes)
                selectedTitles.append(selectedTitle)
            }
            return selectedTitles
        }()
        inputcodeview.CodeTypeControl.setTitles(titles, selectedTitles: selectedTitles)
        inputcodeview.CodeTypeControl.delegate = self
        inputcodeview.CodeTypeControl.backgroundColor = UIColor.clearColor()
        inputcodeview.CodeTypeControl.selectionBoxColor = kLivelyBlueColor
        inputcodeview.CodeTypeControl.selectionBoxCornerRadius = 20
        inputcodeview.CodeTypeControl.selectionBoxStyle = .Default
        inputcodeview.CodeTypeControl.minimumSegmentWidth = 80
    }
    
    
    func segmentedControl(segmentedControl: SegmentedControl, didSelectIndex selectedIndex: Int) {
        switch segmentedControl.style {
        case .Text:
            print("The title is “\(segmentedControl.titles[selectedIndex].string)”\n")
        case .Image:
            print("The image is “\(segmentedControl.images[selectedIndex])”\n")
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
