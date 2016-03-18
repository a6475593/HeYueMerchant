//
//  MyGoodsDetails.swift
//  HeYueMerchant
//
//  Created by 王玉琨 on 16/3/2.
//  Copyright © 2016年 王玉琨. All rights reserved.
//

import UIKit

class MyGoodsDetails: BaseViewController ,UIAlertViewDelegate{
    
    @IBOutlet weak var MyGoodsDetailsView: UIView!
    @IBOutlet weak var MyGoodsNoticeView: UIView!
    @IBOutlet weak var PhoneNumberLabel: UILabel!
    let MyGoodsDetailsTextView = UITextView()
    let MyGoodsNoticeTextView = UITextView()
    let callAlertView = UIAlertView()
    
    @IBOutlet weak var PhoneImageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "商品详情"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: self, action: nil)

        
        PhoneImageButton.addTarget(self, action: #selector(MyGoodsDetails.TelShopAction), forControlEvents: .TouchUpInside)
        MyGoodsDetailsTextView.frame = CGRectMake(0, 0,  self.view.frame.width, MyGoodsDetailsView.frame.height)
        MyGoodsDetailsTextView.selectable = false
        MyGoodsDetailsTextView.editable = false
        MyGoodsDetailsTextView.backgroundColor = UIColor.whiteColor()
        MyGoodsDetailsTextView.font = UIFont.systemFontOfSize(14)
        MyGoodsDetailsTextView.bounces = false
        MyGoodsDetailsTextView.text = "自古以来，人们不仅把柑桔当作佳美的果品，而且大量用在医药上。据科学分析，柑桔果实有大量的糖、维生素C和B,核黄素、蛋白质、钙、尼龙酸脂肪、粗纤维、磷、抗坏血酸、肌醇、无机盐铁等可食营养成份，有助消化、降血压、健脾、止咳化痰、顺气活血之功能，有益于支气管炎、高血压、胆固醇偏高、血管硬化等疾病患者饮食。柑桔果肉性味甘平、微酸，对老弱病者有调肺止渴的功效，桔子含有丰富的葡萄糖、果糖、蔗糖、多种维生素和钾盐，对小便过多、大汗淋漓、痢疾腹泻引起的脱水者，鲜桔汁是良好的滋补剂，也是预防和治疗坏血病的佳品。柑桔全身是宝，除生食外，还可加工成罐头出口。\n其果皮、核、络可广泛应用于食品、化学和医药工业。用柑桔酿的酒和醋，具有特殊的香味；用桔皮和桔花提炼的香精，是重要的化工原料；用桔皮提炼的果胶，还可用来制造果酱和糖果。"
        MyGoodsDetailsView.addSubview(MyGoodsDetailsTextView)
        MyGoodsNoticeTextView.frame = CGRectMake(0, 0, self.view.frame.width, MyGoodsNoticeView.frame.height)
        MyGoodsNoticeTextView.selectable = false
        MyGoodsNoticeTextView.editable = false
        MyGoodsNoticeTextView.backgroundColor = UIColor.whiteColor()
        MyGoodsNoticeTextView.font = UIFont.systemFontOfSize(14)
        MyGoodsNoticeTextView.bounces = false
        MyGoodsNoticeTextView.text = "货比三家。这句话是很多网友线下购买的经验之谈，其实应用在网上购买也是真理。网友们看好一件东西不要急于拍。把商品名字复制一下，在搜索栏里进行搜索，看一下其他商家的价格是如何。\n网友们在网上购买最看重的当然是价格优势了，但是如果有些商家报价过低的话，你就要多注意，这个商家可能是骗子商家，这时候你就需要跟商家多谈一下，了解情况，如果他要求你使用银行转账或先付定金的话，你就可以直接关了聊天框，因为他99%是骗子商家了。因为货物本身都有一定的成本价格，商家不可能亏本做的，就是做活动也会在商城的首页做宣传活动，天上不会无端端掉馅饼给你的！"
        MyGoodsNoticeView.addSubview(MyGoodsNoticeTextView)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func TelShopAction(){
        print("phone")
        callAlertView.title = "提示"
        callAlertView.message = "确定要给\(PhoneNumberLabel.text!)打电话吗？"
        //TelePhoneLabel.text!.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        callAlertView.addButtonWithTitle("取消")
        callAlertView.addButtonWithTitle("确定")
        callAlertView.cancelButtonIndex = 0
        callAlertView.delegate = self
        callAlertView.show()
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        switch alertView{
        case callAlertView:
            if buttonIndex == alertView.cancelButtonIndex{
                return
            }else{
                let phonenumberurl = NSURL(string: "tel://" + PhoneNumberLabel.text!)!
                ShareAPPlication.openURL(phonenumberurl)
            }
        default:break
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
