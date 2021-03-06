//
//  MineVC.swift
//  HeYueMerchant
//
//  Created by 王玉琨 on 15/12/28.
//  Copyright © 2015年 王玉琨. All rights reserved.
//

import UIKit



class MineVC: BaseViewController ,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    
    @IBOutlet weak var PortraitView: UIView!
    @IBOutlet weak var checkPortraitBT: DesignableButton!
    @IBOutlet weak var PortraitImage: DesignableImageView!
    @IBOutlet weak var MainScrollView: UIScrollView!
    @IBOutlet weak var CashView: UIView!
    @IBOutlet weak var CheckView: UIView!
    @IBOutlet weak var MyGoodsView: UIView!
    @IBOutlet weak var CashButton: UIButton!
    @IBOutlet weak var CheckButton: UIButton!
    @IBOutlet weak var MyGoodsButton: UIButton!
    
    
    
    var checkPortraitActionSheet = UIActionSheet()
    let PortraitPickerController = UIImagePickerController()
    let Idleimages = NSMutableArray()
    let Refreshingimages = NSMutableArray()
    let usertype = GetSetValue.integerForKey(USER_TYPE)
    var fromCamera = true
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        ShareAPPlication.setStatusBarStyle(.Default, animated: true)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        PortraitImage.cornerRadius = self.view.frame.height/2.5/2/2
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: self, action: nil)
        checkPortraitBT.addTarget(self, action:
            #selector(MineVC.toCheckPortrait), forControlEvents: .TouchUpInside)
        CashButton.addTarget(self, action: #selector(MineVC.cashaction), forControlEvents: .TouchUpInside)
        self.navigationController?.navigationBar.tintColor = UIColor.blackColor()
        PortraitPickerController.allowsEditing = true
        PortraitPickerController.delegate = self
        
        PortraitImage.sd_setImageWithURL(NSURL(string: "http://article.joyme.com/article/uploads/allimg/201408/1409033740225216.jpg"), placeholderImage: UIImage(named: "myheader.png"), options: .RefreshCached)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        SetUpScrollView()
        SetUpView()
        
    }
    func toCheckPortrait(){
        checkPortraitActionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "拍照", "从相册选择")
        checkPortraitActionSheet.showFromTabBar((self.tabBarController?.tabBar)!)
    }
    
    func cashaction(){
        if usertype == 0 {
            let goodstvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ticketmerchant")
            self.navigationController?.pushViewController(goodstvc, animated: true)
        }else{
            let objectvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("objectmerchant")
            self.navigationController?.pushViewController(objectvc, animated: true)
        }
    }
    
    func actionSheet(actionSheet: UIActionSheet, didDismissWithButtonIndex buttonIndex: Int) {
        switch buttonIndex{
        case 1 ://拍照
            fromCamera = true
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
                PortraitPickerController.sourceType = .Camera
                self.presentViewController(PortraitPickerController, animated: true, completion: nil)
            }else{
                LeafNotification.showInController(self, withText: "您的手机没有相机功能", type: LeafNotificationTypeSuccess)
            }
            break
        case 2 : //从相册选择
            fromCamera = false
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
                PortraitPickerController.sourceType = .PhotoLibrary
                self.presentViewController(PortraitPickerController, animated: true, completion: nil)
            }else{
                LeafNotification.showInController(self, withText: "您的手机没有图库功能", type: LeafNotificationTypeWarrning)
            }
            break
        default : break
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        let portraitimage = editingInfo![UIImagePickerControllerOriginalImage] as! UIImage
        PortraitImage.image = portraitimage
        
        if fromCamera == true{
            UIImageWriteToSavedPhotosAlbum(portraitimage,nil,nil,nil)
            // MARK : - to upload
        }
        LeafNotification.showInController(self, withText: "更改成功", type: LeafNotificationTypeSuccess)
        PortraitPickerController.dismissViewControllerAnimated(true, completion: nil)
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func SetUpScrollView(){
        for i in 1 ..< 60 {
            let image = UIImage(named: "dropdown_anim__000\(i)")
            Idleimages.addObject(image!)
        }
        for i in 1  ..< 3 {
            let image = UIImage(named: "dropdown_loading_0\(i)")
            Refreshingimages.addObject(image!)
        }
        let header  = MJRefreshGifHeader  { () -> Void in
            //MARK: RefreshUserPortrait
        }
        
        header.setImages(Idleimages as [AnyObject], forState: MJRefreshStateIdle)
        header.setImages(Refreshingimages as [AnyObject], forState: MJRefreshStatePulling)
        MainScrollView.header = header
    }
    
    func SetUpView(){
        if usertype == 0 || usertype == 1{
            CheckView.hidden = false
            MyGoodsView.hidden = false
        }else{//商户的权限
            CheckView.hidden = false
            MyGoodsView.hidden = false
        }
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
