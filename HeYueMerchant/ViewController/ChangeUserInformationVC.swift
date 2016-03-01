//
//  ChangeUserInformationVC.swift
//  HeYueMerchant
//
//  Created by 王玉琨 on 15/12/31.
//  Copyright © 2015年 王玉琨. All rights reserved.
//

import UIKit

class ChangeUserInformationVC: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let CompleteButton = UIBarButtonItem(title: "完成", style: UIBarButtonItemStyle.Done, target: self, action: "CompleteAction")
        
        //UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "CompleteAction")
        self.navigationItem.rightBarButtonItem = CompleteButton
       
    }

    func CompleteAction(){
        print("has update user infomation ")
        self.navigationController?.popViewControllerAnimated(true)
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
    
}
