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
    @IBOutlet weak var MerchantIntroTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        remarkTextView.delegate = self
        goodsCountsTextField.delegate = self
        mobileTextField.delegate = self
        goodsCountsButton.addTarget(self, action: "goodsgountsbuttonaction", forControlEvents: .TouchUpInside)
        mobileButton.addTarget(self, action: "mobilebuttonaction", forControlEvents: .TouchUpInside)
        confirmButton.addTarget(self, action: "confirmbuttonaction", forControlEvents: .TouchUpInside)
        MerchantIntroTextView.textAlignment = NSTextAlignment.Left
        MerchantIntroTextView.text = "1.七重天BOSS已到最后阶段，合力击败BOSS即可进入下一重天。\n元神等级上限再提升、更高级元神装备、全新徽章即将开启，相约九重天，全力打BOSS!(1)元神等级上限提升至110级，元神装备开放至帝级\n(2)全新神眼徽章：三界商人亲密度提升\n(3)神之禁地新区域同步开放\n2.植树节活动启动，春暖花开万物复苏之际，赶快来参与灭妖环保，拿最新元神礼包!登上植树排行榜，还有机会获得高级陨星、白虎碎片，更有做人要低调称号等你来!\n3.宠物新技能上线啦，打造强力战斗辅助，开启战斗新篇章，快来为宠物解锁新能力吧!\n(1)神宠白虎独享专属技能：如虎添翼，不但有几率免疫受到的伤害，还可激活霸气新外观\n(2)珍贵宠物将获得超强新技能\n(3)新增哪吒、巨灵两个珍贵品质宠物\n4.“银汉游戏服务中心”微信公众号上线啦，你的专属小秘书，有问必答游戏无忧，快来绑定吧!\n【国战小组赛】\n3月13日20:00-21:15(8进4)\n3月14日20:00-20:35(4进2)\n3月15日\n20:00-20:15(季军赛)\n3月15日20:20-20:35(冠军赛)\n注：比赛期间严打外挂，一旦发现使用外挂者,将取消成绩并封停帐号处理!\n【优化内容】\n1.宝宝工作收益调整：召唤BOSS奖励福禄宝石更改为绑金\n【后续开发预告】\n1.群雄并起，三界大战一触即发，阵营新玩法即将开启，敬请期待!"
        setupView()
    }
    
    func setupView(){
        self.navigationItem.title = "商品详情"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: self, action: nil)
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
