//
//  SubmitAuthCodeVC.swift
//  HeYueMerchant
//
//  Created by 王玉琨 on 16/1/21.
//  Copyright © 2016年 王玉琨. All rights reserved.
//

import UIKit

class SubmitAuthCodeVC: BaseViewController,UITextFieldDelegate {
    
    @IBOutlet weak var ObtainAuthCodeButton: DesignableButton!
    @IBOutlet weak var ObtainAuthCodeTextField: DesignableTextField!
    @IBOutlet weak var ObtainAuthCodeImage: UIImageView!
    @IBOutlet weak var SubmitAutoCode: DesignableButton!
    
    var countDownTimer = NSTimer()
    var secondCountDown = 60
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        ObtainAuthCodeTextField.delegate = self
        obtainauthcodeaction()
        ObtainAuthCodeButton.addTarget(self, action: "obtainauthcodeaction", forControlEvents: .TouchUpInside)
        SubmitAutoCode.addTarget(self, action: "submitautocodeaction", forControlEvents: .TouchUpInside)
        let Obtain = UITapGestureRecognizer(target: self, action: "foucus")
        ObtainAuthCodeImage.addGestureRecognizer(Obtain)

    }
    func foucus(){
        ObtainAuthCodeTextField.becomeFirstResponder()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func submitautocodeaction(){
        //MARK:other net work task
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func obtainauthcodeaction(){
        //MARK 验证验证码的操作
        countDownTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "timeFireMethod", userInfo: nil, repeats: true)
        countDownTimer.fire()
    }
    
    
    func timeFireMethod(){
        if secondCountDown > 0{
            ObtainAuthCodeButton.backgroundColor = UIColor.grayColor()
            ObtainAuthCodeButton.enabled = false
            secondCountDown--
            ObtainAuthCodeButton.titleLabel?.text = "\(secondCountDown)秒后获取"
            ObtainAuthCodeButton.setTitle("\(secondCountDown)秒后获取", forState: UIControlState.Normal)
        }else if secondCountDown == 0{
            ObtainAuthCodeButton.backgroundColor = UIColor(red: 255/255, green: 127/255, blue: 0, alpha: 1.0)
            ObtainAuthCodeButton.enabled = true
            countDownTimer.invalidate()
            secondCountDown = 60
            ObtainAuthCodeButton.titleLabel?.text = "获取验证码"
            ObtainAuthCodeButton.setTitle("获取验证码", forState: UIControlState.Normal)
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
