//
//  ResultVC.swift
//  HeYueMerchant
//
//  Created by 王玉琨 on 16/2/26.
//  Copyright © 2016年 王玉琨. All rights reserved.
//

import UIKit

class ResultVC: BaseViewController {
    var labelstring = String()
    var label = UILabel()
    var navigat = UINavigationBar()
    convenience init(labelstring: String) {
        self.init()
        self.labelstring = labelstring
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Stop, target: self, action: #selector(ResultVC.closeself))
        self.view.backgroundColor = UIColor.grayColor()
        label.text = labelstring
       label.frame = CGRectMake(0, 64, 10, 20)
        label.sizeToFit()
        self.view.addSubview(label)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    let switchViewController = self.navigationController?.viewControllers[1] as! ComposeViewController
//    
//    self.navigationController?.popToViewController(switchViewController, animated: true)
    func closeself(){
        self.navigationController?.popToViewController((self.navigationController?.viewControllers[0])!, animated: true)
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
