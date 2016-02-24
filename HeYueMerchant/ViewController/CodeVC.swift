//
//  CodeVC.swift
//  HeYueMerchant
//
//  Created by 王玉琨 on 16/2/18.
//  Copyright © 2016年 王玉琨. All rights reserved.
//

import UIKit

class CodeVC: BaseViewController {

    @IBOutlet weak var codeimage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        codeimage.image = UIImage.mdQRCodeForString("wangyukun", size: codeimage.bounds.size.width, fillColor: UIColor.blackColor())
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
