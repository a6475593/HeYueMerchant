//
//  EveryOrderDetailsTVC.swift
//  HeYueMerchant
//
//  Created by 王玉琨 on 16/3/5.
//  Copyright © 2016年 王玉琨. All rights reserved.
//

import UIKit

class EveryOrderDetailsTVC: BaseTableViewController {
    let EveryOrderIdentifier = "everyorderidentifier"
    let NoDataCellIdentifier = "nodatacellidentifier"
    let Idleimages = NSMutableArray()
    let Refreshingimages = NSMutableArray()
    var Temporary = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    func IsTemporary(){
        self.navigationItem.title = "当日统计"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: self, action: nil)
        guard Temporary else{
            return
        }
        let SearchButton = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: "tosearchinfomation")
        self.navigationItem.rightBarButtonItem = SearchButton
    }
    
    func tosearchinfomation(){
        let searchinfomationvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("searchinfomation")
        self.navigationController?.pushViewController(searchinfomationvc,animated: true)
    }
    
    func SetUpTableView(){
        
        let everyorderdetailscellnib = UINib(nibName: "OrderDetailsCell", bundle: nil)
        let nodatacellnib = UINib(nibName: "NoDataCell", bundle: nil)
        tableView.separatorStyle = .None
        
        tableView.registerNib(everyorderdetailscellnib, forCellReuseIdentifier: EveryOrderIdentifier)
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
    
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let orderdetailsheadernib = NSBundle.mainBundle().loadNibNamed("OrderDetailsHeader", owner: self, options: nil)
        let orderdetailsheader = orderdetailsheadernib[0] as! OrderDetailsHeader
        if Temporary {
            return orderdetailsheader
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
            let orderdetailscell = tableView.dequeueReusableCellWithIdentifier(EveryOrderIdentifier) as! OrderDetailsCell
            
            return orderdetailscell
        }else{
            let nodatacell = tableView.dequeueReusableCellWithIdentifier(NoDataCellIdentifier) as! NoDataCell
            return nodatacell
        }
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if Temporary{
            return 88
        }else{
            return tableView.frame.height-64
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
