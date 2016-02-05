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
    @IBOutlet weak var UpdateButton: UIButton!
    
    @IBOutlet weak var ShareButton: UIButton!
    
    
    var logoutAlertView = UIAlertView()
    var callAlertView = UIAlertView()
    var clearAlertViewNotempty = UIAlertView()
    var clearAlertViewEmpty = UIAlertView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.blackColor()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "更多信息", style: .Plain, target: self, action: nil)
        logoutButton.addTarget(self, action: "logoutaction", forControlEvents: .TouchUpInside)
        TelePhoneButton.addTarget(self, action: "telephoneaction", forControlEvents: .TouchUpInside)
        ClearCacheButton.addTarget(self, action: "clearcacheaction", forControlEvents: .TouchUpInside)
        UpdateButton.addTarget(self, action: "updateaction", forControlEvents: .TouchUpInside)
        ShareButton.addTarget(self, action: "shareaction", forControlEvents: .TouchUpInside)
        SetUpClearAlertView()
        
        MainScrollView.header = MJRefreshHeader(refreshingBlock: { () -> Void in
            self.MainScrollView.header.endRefreshing()
        })
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let appVersion = GetSetValue.stringForKey(APP_VERSION){
            UpdateButton.setTitle("版本信息:\(appVersion)", forState: .Normal)
            
        }
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
    
    func updateaction(){
        //MARK:不需要么？
    }
    
    func shareaction(){
        UMSocialSnsService.presentSnsIconSheetView(self, appKey: UMENG_ID, shareText: "和悦商家，一款专注移动积分的App。", shareImage:         UIImage(named: "title0.png")
            , shareToSnsNames:
            [   UMShareToSina,//新浪
                UMShareToTencent,//腾讯微博
//                UMShareToEmail,//email
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
