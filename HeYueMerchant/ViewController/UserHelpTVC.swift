//
//  UserHelpTVC.swift
//  HeYueMerchant
//
//  Created by 王玉琨 on 16/1/19.
//  Copyright © 2016年 王玉琨. All rights reserved.
//

import UIKit

class UserHelpTVC: BaseTableViewController {
    let HelpToHelpDetailsIdentifier = "helptohelpdetailsidentifier"
    let titles = ["和包/银行已扣款，和悦订单仍显示未付款，怎么办？1","和包/银行已扣款，和悦订单仍显示未付款，怎么办？2","和包/银行已扣款，和悦订单仍显示未付款，怎么办？3","和包/银行已扣款，和悦订单仍显示未付款，怎么办？4","和包/银行已扣款，和悦订单仍显示未付款，怎么办？5"]
    let content = ["宿舍里，一胖妹子坐床上玩手机，我眼睛随意一瞄，看见一只蜘蛛爬上她的床。 我就对她大喊：哇！！你床上有蜘蛛！有蜘蛛啊！！ 这时，这货怒了，对我大吼：你床上才有只猪！！！ 晚上俩人散步，走到一条比较黑的小路，女的故意跟那男的撒娇说：“会不会有坏人啊，我怕！” 男的马上挺起胸膛说：“别怕，有哥在。” 女的说：“哥，你都有些什么本事？” 只听那货说：“哥跑的快。” 更多搞笑的段子可以点链接观看","我一进网吧的大门,就闻到一股弱者的气息!左脚刚刚踏进,便听到“恭迎LOL大神~~~”这一声在整个网吧的大厅经久不息.原来是一群小学生整齐地跪在两边,我没有细数有多少,我只知道我连踏进另一只脚的地方都没有.我淡定地踢开挡住我道路的小学生.用审视的眼光看着他们,他们都埋着头不敢看我.没办法,强者的光芒实在是太闪耀了.我找了一个空的机子,登了LOL,进入排位模式.身后是小学生惊羡的目光,还有一些小学生害怕地戴上了墨镜,我也不知道为什么.我只是在华丽地躲技能,当我华丽丽地用残血的赵信极限反3杀后,我能感觉到身后的小学生,有的口吐白沫,有的猝死了.因为他们都实在不敢相信,赵信的威力居然有这么大!我下机了,踢开身后的小学生甩了甩衣袖大步流星地出了门,我不知道我这一走又要死多少人,网吧里的打斗声我在外面听得清清楚楚.我笑了,我知道,他们都在抢我刚刚用的那台机子.因为,那里有强者的味道！","今天在路边听到一个淫荡声音“小帅哥快来玩呀” 我内心冷笑“骚货,看我今天不弄死你”,我掏出一块钱硬币,骑在她身上…… 喜羊羊,美羊羊,懒羊羊,沸羊羊,灰太狼……","读大学时交了一个女朋友,因为我爱玩游戏时常会冷落她,她在与我多次交涉未果的情况下毅然提出了分手,每每想起这事我总是后悔不已,所以我要奉劝大家一句,一定不要轻易找女朋友,真的很影响玩游戏的心情","小学时,有次数学考试,由于紧张,要交卷,发现没写名字,关键我竟然忘了自己叫什么……又不敢翻书,怕误以为作弊,正在我左右为难时,灵光一闪,我迅速的给了我同桌一耳光,只见他哭着对老师说：老师,XXX打我. 终于我满意的写上了自己的名字. 至今我依然为我当初的机智感动."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "帮助中心"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: self, action: nil)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return 5
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let HelpCell = UITableViewCell()
        HelpCell.imageView?.image = UIImage(named: "title2.png")
        HelpCell.textLabel?.font = UIFont.systemFontOfSize(14)
        HelpCell.textLabel?.numberOfLines = 2
        HelpCell.textLabel?.text = titles[indexPath.row]
        HelpCell.textLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        HelpCell.selectionStyle = .None
        HelpCell.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        
        return HelpCell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier(HelpToHelpDetailsIdentifier, sender: indexPath.row)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == HelpToHelpDetailsIdentifier{
            let userhelpdetailsvc = segue.destinationViewController as! UserHelpDetailsVC
            let row = sender as! Int
            userhelpdetailsvc.MainTextViewContent = content[row]
        }
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
    
    
    
    
}
