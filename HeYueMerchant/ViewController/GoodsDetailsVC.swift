//
//  GoodsDetailsVC.swift
//  HeYueMerchant
//
//  Created by 王玉琨 on 16/1/5.
//  Copyright © 2016年 王玉琨. All rights reserved.
//

import UIKit

class GoodsDetailsVC: BaseViewController,UITextFieldDelegate,UITextViewDelegate{
    let Idleimages = NSMutableArray()
    let Refreshingimages = NSMutableArray()
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var goodsCountsTextField: DesignableTextField!
    @IBOutlet weak var goodsCountsButton: UIButton!
    @IBOutlet weak var mobileTextField: DesignableTextField!
    @IBOutlet weak var mobileButton: UIButton!
    @IBOutlet weak var remarkLabel: UILabel!
    @IBOutlet weak var remarkTextView: DesignableTextView!
    @IBOutlet weak var confirmButton: DesignableButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        remarkTextView.delegate = self
        goodsCountsTextField.delegate = self
        mobileTextField.delegate = self
        goodsCountsButton.addTarget(self, action: "goodsgountsbuttonaction", forControlEvents: .TouchUpInside)
        mobileButton.addTarget(self, action: "mobilebuttonaction", forControlEvents: .TouchUpInside)
        confirmButton.addTarget(self, action: "confirmbuttonaction", forControlEvents: .TouchUpInside)
        setupView()
    }
    
    func setupView(){
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "商品详情", style: .Plain, target: self, action: nil)
        let SearchButton = UIBarButtonItem(title: "查询余额", style: UIBarButtonItemStyle.Done, target: self, action: "searchremainingaction")
        self.navigationItem.rightBarButtonItem = SearchButton
        for var i = 1;i<60;i++ {
            let image = UIImage(named: "dropdown_anim__000\(i)")
            Idleimages.addObject(image!)
        }
        for var i = 1 ; i < 3; i++ {
            let image = UIImage(named: "dropdown_loading_0\(i)")
            Refreshingimages.addObject(image!)
        }
        let header  = MJRefreshGifHeader  { () -> Void in
        }
        header.setImages(Idleimages as [AnyObject], forState: MJRefreshStateIdle)
        header.setImages(Refreshingimages as [AnyObject], forState: MJRefreshStatePulling)
        mainScrollView.header = header
    }
    
    func searchremainingaction(){
        if isTelNumber(mobileTextField.text!){
            // 请求服务器等后及progress
            LeafNotification.showInController(self, withText: "请求成功，请耐心等待", type: LeafNotificationTypeSuccess)
        }else{
            LeafNotification.showInController(self, withText: "请输入正确的手机号", type: LeafNotificationTypeWarrning)
        }
    }
    
    func goodsgountsbuttonaction(){
        goodsCountsTextField.becomeFirstResponder()
        
    }
    func mobilebuttonaction(){
        mobileTextField.becomeFirstResponder()
        
    }
    
    func textViewDidChange(textView: UITextView) {
        if textView == remarkTextView{
            if textView.text == ""{
                remarkLabel.text = "请输入备注信息"
            }else{
                remarkLabel.text = ""
            }
        }
    }
    
    func confirmbuttonaction() {
        goodsCountsTextField.resignFirstResponder()
        mobileTextField.resignFirstResponder()
        remarkTextView.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        switch textField{
        case goodsCountsTextField:
            if let goodscounts = goodsCountsTextField.text {
                if isNumber(goodscounts){
                    if goodscounts.characters.count > 4{
                        goodsCountsTextField.text = ""
                        goodsCountsTextField.layer.borderColor = UIColor.redColor().CGColor
                    }else{
                        goodsCountsTextField.layer.borderColor = UIColor.blackColor().CGColor
                    }
                }else{
                    if goodscounts == "" {
                        goodsCountsTextField.layer.borderColor = UIColor.blackColor().CGColor
                    }else{
                        goodsCountsTextField.text = ""
                        goodsCountsTextField.layer.borderColor = UIColor.redColor().CGColor
                    }
                }
            }
            break
        case mobileTextField:
            if let mobilephone = mobileTextField.text{
                if isTelNumber(mobilephone){
                    mobileTextField.layer.borderColor = UIColor.blackColor().CGColor
                }else{
                    if mobilephone == ""{
                        mobileTextField.layer.borderColor = UIColor.blackColor().CGColor
                    }else{
                        mobileTextField.layer.borderColor = UIColor.redColor().CGColor
                        mobileTextField.text = ""
                    }
                }
            }
            break
        default : break
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "goosdetailstosubmit"{
            SweetAlert().showAlert("警  告", subTitle: "这将为xx客户发送短信验证码！", style: .Warning, buttonTitle: "确  定", buttonColor: UIColor.colorFromRGB(0xDD6B55), otherButtonTitle: "取  消", otherButtonColor: UIColor.colorFromRGB(0xD0D0D0)) { (isOtherButton) -> Void in
                if isOtherButton{
                    self.performSegueWithIdentifier("goosdetailstosubmit", sender: self)
                }else{
                    return
                }
            }
        }
        return false
    }
    
}
