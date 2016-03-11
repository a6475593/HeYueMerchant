//
//  MoreVC.swift
//  HeYueMerchant
//
//  Created by 王玉琨 on 15/12/28.
//  Copyright © 2015年 王玉琨. All rights reserved.
//

import UIKit

class MoreVC: BaseViewController,UIAlertViewDelegate,UMSocialUIDelegate{
    
    @IBOutlet weak var MainScrollView: UIScrollView!
    @IBOutlet weak var logoutButton: DesignableButton!
    @IBOutlet weak var TelePhoneButton: UIButton!
    @IBOutlet weak var ClearCacheButton: UIButton!
    @IBOutlet weak var ShowVersionMessage: UIButton!
    @IBOutlet weak var ShareButton: UIButton!
    @IBOutlet weak var DismissVersionMessage: SpringButton!
    @IBOutlet weak var VersionMessageView: SpringView!
    @IBOutlet weak var VersionMessageImage: DesignableImageView!
    
    
    @IBOutlet weak var VersionMessageDismissButton: DesignableButton!
    
    var logoutAlertView = UIAlertView()
    var callAlertView = UIAlertView()
    var clearAlertViewNotempty = UIAlertView()
    var clearAlertViewEmpty = UIAlertView()
    
    @IBOutlet weak var MessageTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: self, action: nil)
        logoutButton.addTarget(self, action: "logoutaction", forControlEvents: .TouchUpInside)
        TelePhoneButton.addTarget(self, action: "telephoneaction", forControlEvents: .TouchUpInside)
        ClearCacheButton.addTarget(self, action: "clearcacheaction", forControlEvents: .TouchUpInside)
        ShowVersionMessage.addTarget(self, action: "showversionmessage", forControlEvents: .TouchUpInside)
        DismissVersionMessage.addTarget(self, action: "dismissversionmessage", forControlEvents: .TouchUpInside)
        VersionMessageDismissButton.addTarget(self, action: "dismissversionmessage", forControlEvents: .TouchUpInside)
        ShareButton.addTarget(self, action: "shareaction", forControlEvents: .TouchUpInside)
        
        
        SetUpClearAlertView()
        
        MainScrollView.header = MJRefreshHeader(refreshingBlock: { () -> Void in
            self.MainScrollView.header.endRefreshing()
        })
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        VersionMessageImage.cornerRadius = VersionMessageImage.frame.width / 2
        MessageTextView.selectable = false
        MessageTextView.text = "1.七重天BOSS已到最后阶段，合力击败BOSS即可进入下一重天。\n元神等级上限再提升、更高级元神装备、全新徽章即将开启，相约九重天，全力打BOSS!(1)元神等级上限提升至110级，元神装备开放至帝级\n(2)全新神眼徽章：三界商人亲密度提升\n(3)神之禁地新区域同步开放\n2.植树节活动启动，春暖花开万物复苏之际，赶快来参与灭妖环保，拿最新元神礼包!登上植树排行榜，还有机会获得高级陨星、白虎碎片，更有做人要低调称号等你来!\n3.宠物新技能上线啦，打造强力战斗辅助，开启战斗新篇章，快来为宠物解锁新能力吧!\n(1)神宠白虎独享专属技能：如虎添翼，不但有几率免疫受到的伤害，还可激活霸气新外观\n(2)珍贵宠物将获得超强新技能\n(3)新增哪吒、巨灵两个珍贵品质宠物\n4.“银汉游戏服务中心”微信公众号上线啦，你的专属小秘书，有问必答游戏无忧，快来绑定吧!\n【国战小组赛】\n3月13日20:00-21:15(8进4)\n3月14日20:00-20:35(4进2)\n3月15日\n20:00-20:15(季军赛)\n3月15日20:20-20:35(冠军赛)\n注：比赛期间严打外挂，一旦发现使用外挂者,将取消成绩并封停帐号处理!\n【优化内容】\n1.宝宝工作收益调整：召唤BOSS奖励福禄宝石更改为绑金\n【后续开发预告】\n1.群雄并起，三界大战一触即发，阵营新玩法即将开启，敬请期待!"
        MessageTextView.textAlignment = NSTextAlignment.Left
      
        
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let appVersion = GetSetValue.stringForKey(APP_VERSION){
            ShowVersionMessage.setTitle("版本信息:\(appVersion)", forState: .Normal)
        }
    }
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        dismissversionmessage()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func logoutaction(){
        logoutAlertView.title = "提示"
        logoutAlertView.message = "确定要退出登录吗"
        logoutAlertView.addButtonWithTitle("取消")
        logoutAlertView.addButtonWithTitle("确定")
        logoutAlertView.cancelButtonIndex = 0
        logoutAlertView.delegate = self
        logoutAlertView.show()
    }
    
    func telephoneaction(){
        callAlertView.title = "提示"
        callAlertView.message = "确定要给\(CUSTOMER_SERVICE_PHONE_NUMBER)打电话吗？"
        //TelePhoneLabel.text!.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        callAlertView.addButtonWithTitle("取消")
        callAlertView.addButtonWithTitle("确定")
        callAlertView.cancelButtonIndex = 0
        callAlertView.delegate = self
        callAlertView.show()
    }
    func clearcacheaction(){
        let cachepath = NSHomeDirectory().stringByAppendingString("/Library/Caches/default")
        
        if FileManager.fileExistsAtPath(cachepath){
            //MARK: size's units is bytes
            let size = SDImageCache.sharedImageCache().getSize()
            let sizedouble = Double(size)
            let sizeKB = NSString(format: "%.2f", sizedouble/1024)
            let sizeMB = NSString(format: "%.2f", sizedouble/1048576)
            if size > 0 {
                if size/1048576 < 1{
                    clearAlertViewNotempty.message = "缓存文件大小为\(sizeKB)KB，确定清空缓存？"
                }else{
                    clearAlertViewNotempty.message = "缓存文件大小为\(sizeMB)MB，确定清空缓存？"
                }
                clearAlertViewNotempty.show()
            }else{
                clearAlertViewEmpty.show()
            }
        }else{
            clearAlertViewEmpty.show()
        }
        
    }
    
    func alertView(alertView:UIAlertView, clickedButtonAtIndex buttonIndex: Int){
        switch alertView{
        case logoutAlertView:
            if(buttonIndex==alertView.cancelButtonIndex){
                return
            } else {
                //MARK:Umeng 登出
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            
            break
        case callAlertView:
            if(buttonIndex==alertView.cancelButtonIndex){
                return
            } else {
                let myurl = NSURL(string: "tel://" + CUSTOMER_SERVICE_PHONE_NUMBER)!
                //TelePhoneLabel.text!.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
                ShareAPPlication.openURL(myurl)
            }
            break
        case clearAlertViewNotempty:
            if(buttonIndex==alertView.cancelButtonIndex){
                return
            } else {
                SDImageCache.sharedImageCache().clearDisk()
                SDImageCache.sharedImageCache().clearMemory()
                SDImageCache.sharedImageCache().cleanDisk()
            }
            break
        default:break
        }
    }
    func SetUpClearAlertView(){
        clearAlertViewNotempty.title = "清理缓存"
        clearAlertViewNotempty.addButtonWithTitle("取消")
        clearAlertViewNotempty.addButtonWithTitle("确定")
        clearAlertViewNotempty.cancelButtonIndex = 0
        clearAlertViewNotempty.delegate = self
        
        clearAlertViewEmpty.message = "当前没有缓存"
        clearAlertViewEmpty.addButtonWithTitle("确定")
        clearAlertViewEmpty.delegate = self
    }
    
    func showversionmessage(){
        DismissVersionMessage.hidden = false
        VersionMessageView.animation = "zoomIn"
        VersionMessageView.animate()
    }
    
    func dismissversionmessage(){
        DismissVersionMessage.hidden = true
        VersionMessageView.animation = "zoomOut"
        VersionMessageView.animate()
    }
    
    func shareaction(){
        UMSocialSnsService.presentSnsIconSheetView(self, appKey: UMENG_ID, shareText: "和悦商家，一款专注移动积分的App。", shareImage: UIImage(named: "title0.png")
            , shareToSnsNames:
            [   UMShareToSina,//新浪
                UMShareToTencent,//腾讯微博
                //UMShareToEmail,//email
                UMShareToSms,//短信
                UMShareToQQ,//QQ
                UMShareToQzone,//QQ空间
                UMShareToWechatSession,//微信好友
                UMShareToWechatTimeline,//微信朋友圈
                UMShareToWechatFavorite//微信收藏
            ],
            delegate: self)
        let baidu = "http://www.baidu.com/"
        UMSocialData.defaultData().extConfig.sinaData.urlResource.url = baidu
        UMSocialData.defaultData().extConfig.tencentData.urlResource.url = baidu
        UMSocialData.defaultData().extConfig.smsData.urlResource.url = baidu
        UMSocialData.defaultData().extConfig.qqData.url = baidu
        UMSocialData.defaultData().extConfig.qzoneData.url = baidu
        UMSocialData.defaultData().extConfig.wechatSessionData.url = baidu
        UMSocialData.defaultData().extConfig.wechatTimelineData.url = baidu
        UMSocialData.defaultData().extConfig.wechatFavoriteData.url = baidu
        
        
        
        
    }
    func didFinishGetUMSocialDataInViewController(response: UMSocialResponseEntity!) {
        //        if response.responseCode == UMSResponseCodeSuccess {
        //            LeafNotification.showInController(self, withText: "分享成功", type: LeafNotificationTypeSuccess)
        //        }
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
