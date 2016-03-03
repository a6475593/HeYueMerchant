//
//  ShopsDetailsTVC.swift
//  HeYueMerchant
//
//  Created by 王玉琨 on 16/3/3.
//  Copyright © 2016年 王玉琨. All rights reserved.
//

import UIKit

class ShopsDetailsTVC: BaseTableViewController {
    let ShopsDetailsIdentifier = "shopsdetailsidentifier"
    let NoDataCellIdentifier = "nodatacellidentifier"
    let Idleimages = NSMutableArray()
    let Refreshingimages = NSMutableArray()
    var Temporary = true
    override func viewDidLoad() {
        super.viewDidLoad()
        if GetSetValue.integerForKey(USER_TYPE) == 0 {
            Temporary = true
        }else if GetSetValue.integerForKey(USER_TYPE) == 1{
            Temporary = false
        }
        IsTemporary()
        SetUpTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func SetUpTableView(){
        
        let shopsdetailscellnib = UINib(nibName: "TradeDetails", bundle: nil)
        let nodatacellnib = UINib(nibName: "NoDataCell", bundle: nil)
        tableView.separatorStyle = .None
        
        tableView.registerNib(shopsdetailscellnib, forCellReuseIdentifier: ShopsDetailsIdentifier)
        tableView.registerNib(nodatacellnib, forCellReuseIdentifier: NoDataCellIdentifier)
        
        
        for var i = 1;i<60;i++ {
            let image = UIImage(named: "dropdown_anim__000\(i)")
            Idleimages.addObject(image!)
        }
        for var i = 1 ; i < 3; i++ {
            let image = UIImage(named: "dropdown_loading_0\(i)")
            Refreshingimages.addObject(image!)
        }
        let header  = MJRefreshGifHeader  { () -> Void in
        }
        let footer = MJRefreshBackGifFooter { () -> Void in
        }
        header.setImages(Idleimages as [AnyObject], forState: MJRefreshStateIdle)
        header.setImages(Refreshingimages as [AnyObject], forState: MJRefreshStatePulling)
        footer.setImages(Idleimages as [AnyObject], forState: MJRefreshStateIdle)
        footer.setImages(Refreshingimages as [AnyObject], forState:MJRefreshStatePulling)
        if Temporary{
            tableView.header = header
            tableView.footer = footer
        }else{
            tableView.header = header
            tableView.footer = nil
        }
    }
    
    func IsTemporary(){
        guard Temporary else{
            return
        }
        let SearchButton = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: "tosearchinfomation")
        self.navigationItem.rightBarButtonItem = SearchButton
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "当日情况", style: .Plain, target: self, action: nil)
    }
    
    func tosearchinfomation(){
        let searchinfomationvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("searchinfomation")
        self.navigationController?.pushViewController(searchinfomationvc, animated: true)
    }
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let trandedetailsheadernib = NSBundle.mainBundle().loadNibNamed("ShopsDetailsHeader", owner: self, options: nil)
        let trandedetailsheader = trandedetailsheadernib[0] as! ShopsDetailsHeader
        if Temporary {
            return trandedetailsheader
        }else{
            return nil
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if Temporary{
            return 88
        }else{
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let trandedetailsfooternib = NSBundle.mainBundle().loadNibNamed("TrandeDetailsFooter", owner: self, options: nil)
        let trandedetailsfooter = trandedetailsfooternib[0] as! TrandeDetailsFooter
        if Temporary {
            return trandedetailsfooter
        }else{
            return nil
        }
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if Temporary{
            return 44
        }else{
            return 0
        }
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Temporary{
            return 20
        }else{
            return 1
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if Temporary {
            let shopsdetailscell = tableView.dequeueReusableCellWithIdentifier(ShopsDetailsIdentifier) as! TradeDetails
            shopsdetailscell.First.text = "米莎贝尔平安店"
            shopsdetailscell.Second.text = "6666.66"
            shopsdetailscell.Third.text = "66"
            return shopsdetailscell
        }else{
            let nodatacell = tableView.dequeueReusableCellWithIdentifier(NoDataCellIdentifier) as! NoDataCell
            return nodatacell
        }
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if Temporary{
            return 44
        }else{
            return tableView.frame.height-64
        }
    }

//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        self.performSegueWithIdentifier("tradedetailstoeachdetails", sender: indexPath.row)
//    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
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
