//
//  ObjectMerchantVC.swift
//  HeYueMerchant
//
//  Created by 王玉琨 on 16/1/28.
//  Copyright © 2016年 王玉琨. All rights reserved.
//

import UIKit

class ObjectMerchantVC: BaseViewController {

    @IBOutlet weak var userPhoneTextField: DesignableTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let SearchButton = UIBarButtonItem(title: "查询余额", style: UIBarButtonItemStyle.Done, target: self, action: #selector(ObjectMerchantVC.searchremainingaction))
        self.navigationItem.rightBarButtonItem = SearchButton
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchremainingaction(){
        if isTelNumber(userPhoneTextField.text!){
            // 请求服务器等后及progress
            LeafNotification.showInController(self, withText: "请求成功，请耐心等待", type: LeafNotificationTypeSuccess)
        }else{
            LeafNotification.showInController(self, withText: "请输入正确的手机号", type: LeafNotificationTypeWarrning)
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
