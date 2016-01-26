//
//  UserHelpDetailsVC.swift
//  HeYueMerchant
//
//  Created by 王玉琨 on 16/1/19.
//  Copyright © 2016年 王玉琨. All rights reserved.
//

import UIKit

class UserHelpDetailsVC: BaseViewController {
    
    @IBOutlet weak var MainTextView: UITextView!
    var MainTextViewContent = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        MainTextView.text = MainTextViewContent
        // Do any additional setup after loading the view.
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
