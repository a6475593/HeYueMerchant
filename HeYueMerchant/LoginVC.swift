//
//  LoginVC.swift
//  HeYueMerchant
//
//  Created by 王玉琨 on 15/12/28.
//  Copyright © 2015年 王玉琨. All rights reserved.
//

import UIKit

class LoginVC: BaseViewController,EAIntroDelegate,UITextFieldDelegate{
    
    @IBOutlet weak var WelcomeLabel: UILabel!
    @IBOutlet weak var usernameTF: DesignableTextField!
    @IBOutlet weak var passwordTF: DesignableTextField!
    @IBOutlet weak var isRememberPassWord: UIImageView!
    @IBOutlet weak var isRememberBT: DesignableButton!
    @IBOutlet weak var isRememberImage: UIImageView!
    @IBOutlet weak var loginButton: DesignableButton!
    @IBOutlet weak var resigntextfieldBT: UIButton!
    @IBOutlet weak var usernameImage: UIImageView!
    @IBOutlet weak var passwordImage: UIImageView!
    @IBOutlet weak var mainIndicator: UIActivityIndicatorView!
    
    var isRememberpassword : Bool = false
    let  shadowAnimation =  JTSlideShadowAnimation()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        shadowAnimation.animatedView = WelcomeLabel
        shadowAnimation.start()
        passwordTF.delegate = self
        if SSKeychain.passwordForService(COM_FUSIDE_HEYUE_MERCHANT, account: USER_PASS_WORD) == nil{
            isRememberImage.image = UIImage(named: "check")
            isRememberpassword = false
        }else{
            if SSKeychain.passwordForService(COM_FUSIDE_HEYUE_MERCHANT, account: USER_PASS_WORD) != "" {
                isRememberImage.image = UIImage(named: "checked")
                isRememberpassword = true
                passwordTF.text = SSKeychain.passwordForService(COM_FUSIDE_HEYUE_MERCHANT, account: USER_PASS_WORD)
            }else{
                isRememberImage.image = UIImage(named: "check")
                isRememberpassword = false
                passwordTF.text = SSKeychain.passwordForService(COM_FUSIDE_HEYUE_MERCHANT, account: USER_PASS_WORD)
            }
        }
        if SSKeychain.passwordForService(COM_FUSIDE_HEYUE_MERCHANT, account: USER_NAME) == nil{
            return
        }else{
            usernameTF.text = SSKeychain.passwordForService(COM_FUSIDE_HEYUE_MERCHANT, account: USER_NAME)
        }
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        usernameTF.endEditing(true)
        passwordTF.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        isRememberBT.addTarget(self, action: "isRememberpasswordBTAction", forControlEvents: .TouchUpInside)
        resigntextfieldBT.addTarget(self, action: "resignfirsttextfield", forControlEvents: .TouchUpInside)
        
        let usernamerecognizer = UITapGestureRecognizer(target: self, action: "userbecomefirst")
        usernameImage.addGestureRecognizer(usernamerecognizer)
        let passwordrecognizer = UITapGestureRecognizer(target: self, action: "passwordbecomefirst")
        passwordImage.addGestureRecognizer(passwordrecognizer)
        loginButton.addTarget(self, action: "loginAction", forControlEvents: .TouchUpInside)
        WhethershowUserGuider()
        mainIndicator.stopAnimating()
        ShareAPPlication.networkActivityIndicatorVisible = false
        
        
    }
    
    func isRememberpasswordBTAction(){
        isRememberpassword = !isRememberpassword
        if isRememberpassword{
            isRememberImage.image = UIImage(named: "checked")
        }else{
            isRememberImage.image = UIImage(named: "check")
        }
    }
    
    func resignfirsttextfield(){
        usernameTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
    }
    
    func userbecomefirst(){
        usernameTF.becomeFirstResponder()
    }
    
    func passwordbecomefirst(){
        passwordTF.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func WhethershowUserGuider(){
        let infoDictionary = NSBundle.mainBundle().infoDictionary
        let currentAppVersion = infoDictionary!["CFBundleShortVersionString"] as! String
        let appVersion = GetSetValue.stringForKey(APP_VERSION)
        if appVersion == currentAppVersion{
            return
        }else{
            GetSetValue.setObject(currentAppVersion, forKey: APP_VERSION)
            let rootView : UIView  = (self.navigationController?.view)!
            let page1 = EAIntroPage()
            let page2 = EAIntroPage()
            let page3 = EAIntroPage()
            let page4 = EAIntroPage()
            let pagearray = [page1,page2,page3,page4]
            
            for var i = 0 ; i < 4; i++ {
                pagearray[i].title = titlearray[i]
                pagearray[i].desc = introducearray[i]
                pagearray[i].bgImage = UIImage(named: "bg\(i).png")
                pagearray[i].titleIconView = UIImageView(image: UIImage(named: "title\(i).png"))
            }
            let scrollview = EAIntroView.init(frame: rootView.bounds, andPages: [page1,page2,page3,page4])
            scrollview.delegate = self
            scrollview.showInView(rootView, animateDuration: 0.3)
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField == passwordTF{
            if string == "\n"{
                loginAction()
                shouldPerformSegueWithIdentifier("logintomine", sender: self)
                return false
            }else{
                return true
            }
        }
        return true
    }
    
    
    func loginAction() {
        mainIndicator.startAnimating()
        ShareAPPlication.networkActivityIndicatorVisible = true
        usernameTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        let username = self.usernameTF.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let password = self.passwordTF.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        if identifier == "logintomine"{
            let url = "http://apis.baidu.com/netpopo/express/express2"
            request(.GET, url, parameters: nil, encoding: .JSON).responseJSON { (response) -> Void in
                if response.result.isFailure {
                    LeafNotification.showInController(self, withText: "您的网络好像挂了", type: LeafNotificationTypeWarrning)
                }else if response.result.isSuccess {
                    //MARK
                    
                    SSKeychain.setPassword(password, forService: COM_FUSIDE_HEYUE_MERCHANT, account: USER_PASS_WORD)
                    
                    if response.response?.statusCode == 200 && username == "wang" && password == "yukun"{
                        //MARK:Umeng 帐号统计
                        MobClick.profileSignInWithPUID(username)
                        //MARK:页面
                        self.mainIndicator.stopAnimating()
                        ShareAPPlication.networkActivityIndicatorVisible = false
                        if self.usernameTF.text != nil && self.usernameTF.text != ""{
                            SSKeychain.setPassword(username, forService: COM_FUSIDE_HEYUE_MERCHANT, account: USER_NAME)
                        }
                        if self.isRememberpassword{
                            SSKeychain.setPassword(password, forService: COM_FUSIDE_HEYUE_MERCHANT, account: USER_PASS_WORD)
                        }else{
                            SSKeychain.setPassword("", forService: COM_FUSIDE_HEYUE_MERCHANT, account: USER_PASS_WORD)
                        }
                        //MARK:跳转
                        self.performSegueWithIdentifier("logintomine", sender: self)
                        //MARK:网络
                        if let value = response.result.value {
                            let data = JSON(value)
                            print("from server data is \(data)")
                        }
                    }else if response.response?.statusCode == 404 {
                        self.mainIndicator.stopAnimating()
                        ShareAPPlication.networkActivityIndicatorVisible = false
                        LeafNotification.showInController(self, withText: "404错误，请联系我们", type: LeafNotificationTypeWarrning)
                    }else if response.response?.statusCode == 500{
                        self.mainIndicator.stopAnimating()
                        ShareAPPlication.networkActivityIndicatorVisible = false
                        LeafNotification.showInController(self, withText: "500错误，请联系我们", type: LeafNotificationTypeWarrning)
                    }else{
                        self.mainIndicator.stopAnimating()
                        ShareAPPlication.networkActivityIndicatorVisible = false
                        LeafNotification.showInController(self, withText: "未知错误，请联系我们", type: LeafNotificationTypeWarrning)
                    }
                }
            }
        }
        return false
    }
}
