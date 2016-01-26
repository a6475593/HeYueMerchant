//
//  UserGuiderVC.swift
//  HeYueMerchant
//
//  Created by 王玉琨 on 15/12/29.
//  Copyright © 2015年 王玉琨. All rights reserved.
//

import UIKit

class UserGuiderVC: BaseViewController {
      override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    /*
    var pageControl: UIPageControl!
    var scrollView: UIScrollView!
    var imgCount: Int!
    var imgArray: Array<String>!
    
    convenience  init(imageArray anImgArray: Array<String>)
    {
    self.init()
    imgArray = anImgArray
    imgCount = imgArray.count
    
    }
    
    override func viewDidLoad() {
    super.viewDidLoad()
    let screenWidth = Define.screenWidth()
    let screenHeight = Define.screenHeight()
    
    //scrollView
    scrollView = UIScrollView(frame: self.view.bounds)
    scrollView.delegate=self
    scrollView.bounces = false
    scrollView.showsHorizontalScrollIndicator = false
    scrollView.pagingEnabled = true
    scrollView.contentSize = CGSizeMake(screenWidth * CGFloat(self.imgCount), screenHeight)
    self.view.addSubview(scrollView)
    
    scrollView.layer.borderColor =  UIColor.clearColor().CGColor
    scrollView.layer.borderWidth = 2
    for var i = 0; i < imgArray.count; i++
    {
    let imgView = UIImageView(frame: CGRectMake(screenWidth * CGFloat(i), 0, screenWidth, screenHeight))
    imgView.image = UIImage(named: imgArray[i])
    imgView.userInteractionEnabled = false
    scrollView.addSubview(imgView)
    
    if(i == imgArray.count - 1)
    {
    let btn = UIButton(type: UIButtonType.Custom)
    btn.frame = CGRectMake(0, 0, 120, 40)
    btn.layer.borderColor = UIColor.whiteColor().CGColor
    btn.layer.borderWidth = 2
    btn.layer.cornerRadius = 6
    btn.center = CGPointMake(screenWidth/2, screenHeight - 100)
    btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
    btn.setTitle("开始进入 >", forState: UIControlState.Normal)
    btn.addTarget(self, action:"btnClicked", forControlEvents: UIControlEvents.TouchUpInside)
    imgView.addSubview(btn)
    imgView.userInteractionEnabled = true
    }
    }
    
    
    pageControl = UIPageControl(frame: CGRectMake(0, 0, 50, 20))
    pageControl.center = CGPointMake(screenWidth/2, screenHeight-40)
    pageControl.numberOfPages=self.imgCount
    self.view.addSubview(pageControl)
    }
    
    func btnClicked()
    {
    GetSetValue.setBool(true, forKey: HAD_SHOWN_USER_GUIDER_VC)
    
    self.dismissViewControllerAnimated(true, completion: nil)
    //        self.presentViewController(citylist, animated: false, completion: nil)
    
    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
    let page = Int(scrollView.contentOffset.x / Define.screenWidth())
    pageControl.currentPage = page
    }
    */
}

