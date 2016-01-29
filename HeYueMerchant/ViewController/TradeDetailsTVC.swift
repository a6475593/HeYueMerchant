//
//  TradeDetailsTVC.swift
//  HeYueMerchant
//
//  Created by 王玉琨 on 16/1/11.
//  Copyright © 2016年 王玉琨. All rights reserved.
//

import UIKit

class TradeDetailsTVC: BaseTableViewController {
    let TradeDetailsIdentifier = "tradedetailsidentifier"
    let NoDataCellIdentifier = "nodatacellidentifier"
    let Idleimages = NSMutableArray()
    let Refreshingimages = NSMutableArray()
    let Temporary = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Umeng 页面统计
        MobClick.beginLogPageView("交易详情列表页")
        SetUpTableView()
        IsTemporary()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillAppear(animated)
        MobClick.endLogPageView("交易详情列表页")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func SetUpTableView(){
        
        let tradedetailscellnib = UINib(nibName: "TradeDetails", bundle: nil)
        let nodatacellnib = UINib(nibName: "NoDataCell", bundle: nil)
        tableView.separatorStyle = .None
        
        tableView.registerNib(tradedetailscellnib, forCellReuseIdentifier: TradeDetailsIdentifier)
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
    
    func tosearchinfomation(){
        let searchinfomationvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("searchinfomation")
        self.navigationController?.pushViewController(searchinfomationvc, animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if Temporary{
            return 44
        }else{
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let trandedetailsheadenib = NSBundle.mainBundle().loadNibNamed("TradeDetailsHeader", owner: self, options: nil)
        let trandedetailsheader = trandedetailsheadenib[0] as! TradeDetailsHeader
        trandedetailsheader.frame = CGRectMake(0, tableView.frame.width/2-40, tableView.frame.width, 80)
        if Temporary {
            return trandedetailsheader
        }else{
            return nil
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
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
            let tradedetailscell = tableView.dequeueReusableCellWithIdentifier(TradeDetailsIdentifier) as! TradeDetails
            return tradedetailscell
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
    func IsTemporary(){
        guard Temporary else{
            return
        }
        let SearchButton = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: "tosearchinfomation")
        self.navigationItem.rightBarButtonItem = SearchButton
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "交易统计", style: .Plain, target: self, action: nil)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
