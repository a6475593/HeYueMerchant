//
//  MineVC.swift
//  HeYueMerchant
//
//  Created by 王玉琨 on 15/12/28.
//  Copyright © 2015年 王玉琨. All rights reserved.
//

import UIKit



class MineVC: BaseViewController ,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    
    @IBOutlet weak var checkPortraitBT: DesignableButton!
    @IBOutlet weak var PortraitImage: DesignableImageView!
    @IBOutlet weak var MainScrollView: UIScrollView!
    var checkPortraitActionSheet = UIActionSheet()
    let PortraitPickerController = UIImagePickerController()
    let Idleimages = NSMutableArray()
    let Refreshingimages = NSMutableArray()
    var fromCamera = true
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        

     
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "和悦商户", style: .Plain, target: self, action: nil)
        checkPortraitBT.addTarget(self, action:
            "toCheckPortrait", forControlEvents: .TouchUpInside)
        self.navigationController?.navigationBar.tintColor = UIColor.blackColor()
        PortraitPickerController.allowsEditing = true
        PortraitPickerController.delegate = self
        
        PortraitImage.sd_setImageWithURL(NSURL(string: "http://article.joyme.com/article/uploads/allimg/201408/1409033740225216.jpg"), placeholderImage: UIImage(named: "myheader.png"), options: .RefreshCached)
        SetUpScrollView()
        
        
    }
    func toCheckPortrait(){
        checkPortraitActionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "拍照", "从相册选择")
        checkPortraitActionSheet.showFromTabBar((self.tabBarController?.tabBar)!)
        
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
        for var i = 1;i<60;i++ {
            let image = UIImage(named: "dropdown_anim__000\(i)")
            Idleimages.addObject(image!)
        }
        for var i = 1 ; i < 3; i++ {
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
