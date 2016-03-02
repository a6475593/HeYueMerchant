//
//  GoodsVC.swift
//  HeYueMerchant
//
//  Created by 王玉琨 on 16/1/5.
//  Copyright © 2016年 王玉琨. All rights reserved.
//

import UIKit

class GoodsTVC: BaseTableViewController {
    let GoodsCellIdentifier = "goodscellidentifier"
    let Idleimages = NSMutableArray()
    let Refreshingimages = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "商品列表", style: .Plain, target: self, action: nil)
        setupView()

    }

    func setupView(){
        let goodscellnib = UINib(nibName: "Goods", bundle: nil)
        tableView.registerNib(goodscellnib, forCellReuseIdentifier: GoodsCellIdentifier)
        
        tableView.separatorColor = UIColor.blueColor()
        
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
        tableView.header = header
        tableView.footer = footer
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 13
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let goodscell  = tableView.dequeueReusableCellWithIdentifier(GoodsCellIdentifier) as! Goods
        goodscell.goodsImage.sd_setImageWithURL(NSURL(string: "http://down.tutu001.com/d/file/20110415/e355ebc7e2e327ecc9a5017007_560.jpg"), placeholderImage: UIImage(named: "giraffe.png"), options: .RefreshCached)
        return goodscell
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("goodtodetailsidentifier", sender: indexPath.row)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goodtodetailsidentifier"{
            //            let goodsdetailsvc = segue.destinationViewController as! GoodsDetailsVC
            //             goodsdetailsvc.xx = sender
        }
        
        
        
    }
    
    
}
