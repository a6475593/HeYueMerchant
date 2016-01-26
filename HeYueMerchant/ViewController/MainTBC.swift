//
//  MainTBC.swift
//  HeYueMerchant
//
//  Created by 王玉琨 on 15/12/28.
//  Copyright © 2015年 王玉琨. All rights reserved.
//

import UIKit

class MainTBC: UITabBarController ,SKSplashDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1.0)
        let allItems  = self.tabBar.items!
        
        
        let MineTabbarItem = allItems[0]
        let MoreTabbarItem = allItems[1]
        SetTabBarItem(MineTabbarItem,Image: "mine",SelectedImage:"mineselected", title: "我的")
        SetTabBarItem(MoreTabbarItem,Image: "more",SelectedImage:"moreselected", title: "更多")
    }
    
    func SetTabBarItem(TabBarItem:UITabBarItem,Image:String,SelectedImage:String,title:String){
        TabBarItem.image = UIImage(named: Image)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        TabBarItem.selectedImage = UIImage(named: SelectedImage)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        TabBarItem.title = title
        //UIColor(red: 22, green: 169, blue: 238, alpha: 1)
        TabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor(red: 22/255, green: 169/255, blue: 238/255, alpha: 1.0)], forState: UIControlState.Selected)
        TabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.grayColor()], forState: UIControlState.Normal)
        
    }
    
    func HeYueSplash(){
        let heyueSpalshIcon = SKSplashIcon.init(image: UIImage(named: "giraffe.png"), animationType: .Bounce)
        let color = UIColor(red: 0.25098, green: 0.6, blue: 1.0, alpha: 1.0)
        let splashView = SKSplashView.init(splashIcon: heyueSpalshIcon, backgroundColor: color, animationType: .None)
        splashView.delegate = self
        splashView.animationDuration = 3
        self.view.addSubview(splashView)
        splashView.startAnimation()
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
