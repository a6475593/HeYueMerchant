//
//  LGScanVC.swift
//  HeYueMerchant
//
//  Created by 王玉琨 on 16/2/18.
//  Copyright © 2016年 王玉琨. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation
import AudioToolbox


class LGScanVC: BaseViewController , AVCaptureMetadataOutputObjectsDelegate{
    
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    let screenHeight = UIScreen.mainScreen().bounds.size.height
    let screenSize = UIScreen.mainScreen().bounds.size
    
    var traceNumber = 0
    var upORdown = false
    var timer:NSTimer!
    
    let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
    let session = AVCaptureSession()
    var input  : AVCaptureDeviceInput!
    var layer  : AVCaptureVideoPreviewLayer!
    var line   : UIImageView!
    var player = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "二维码扫描"
        setupScanLine()
        self.view.addSubview(makeScanCameraShadowView(makeScanReaderRect()))
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setupCamera()
        timer = NSTimer(timeInterval: 0.02, target: self, selector: #selector(LGScanVC.scanLineAnimation), userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSDefaultRunLoopMode)
        self.session.startRunning()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        traceNumber = 0
        upORdown = false
        timer.invalidate()
        timer = nil
    }
    
    func setupCamera(){
        //高质量采集率
        self.session.sessionPreset = AVCaptureSessionPresetHigh
        var error : NSError?
        let frame = self.view.frame
        let rect = makeScanReaderRect()
        
        //输入流
        let input : AVCaptureDeviceInput!
        do{
            input = try AVCaptureDeviceInput(device: device)
        }
            //异常处理
        catch let error1 as NSError {
            error  = error1
            input = nil
        }
        if(error != nil){
            print(error?.description)
            return
        }
        if session.canAddInput(input){
            session.addInput(input)
        }
        //显示图像
        layer =  AVCaptureVideoPreviewLayer(session: session)
        layer.videoGravity = AVLayerVideoGravityResizeAspectFill
        layer.frame = frame
        
        self.view.layer.insertSublayer(self.layer!, atIndex: 0)
        let output = AVCaptureMetadataOutput()
        
        //设置代理在主线程里刷新makescr
        output.rectOfInterest = CGRectMake(rect.origin.y/frame.height,rect.origin.x/frame.width,rect.height/frame.height,rect.width/frame.width)
        output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        if session.canAddOutput(output) {
            session.addOutput(output)
            //设置扫码支持的编码格式（如下设置各种条形码和二维码兼容）
            output.metadataObjectTypes = [ AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeUPCECode,AVMetadataObjectTypePDF417Code,
                AVMetadataObjectTypeAztecCode,
                AVMetadataObjectTypeCode93Code,
                AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeCode39Mod43Code];
        }
        session.startRunning()
    }
    
    func setupScanLine() {
        let rect = makeScanReaderRect()
        
        var imageSize: CGFloat = 20.0
        let imageX = rect.origin.x
        let imageY = rect.origin.y
        let width = rect.size.width
        let height = rect.size.height + 2
        
        /// 四个边角
        let imageViewTL = UIImageView(frame: CGRectMake(imageX, imageY, imageSize, imageSize))
        imageViewTL.image = UIImage(named: "scan_tl")
        imageSize = (imageViewTL.image?.size.width)!
        self.view.addSubview(imageViewTL)
        
        let imageViewTR = UIImageView(frame: CGRectMake(imageX + width - imageSize, imageY, imageSize, imageSize))
        imageViewTR.image = UIImage(named: "scan_tr")
        self.view.addSubview(imageViewTR)
        
        let imageViewBL = UIImageView(frame: CGRectMake(imageX, imageY + height - imageSize, imageSize, imageSize))
        imageViewBL.image = UIImage(named: "scan_bl")
        self.view.addSubview(imageViewBL)
        
        let imageViewBR = UIImageView(frame: CGRectMake(imageX + width - imageSize, imageY + height - imageSize, imageSize, imageSize))
        imageViewBR.image = UIImage(named: "scan_br")
        self.view.addSubview(imageViewBR)
        
        line = UIImageView(frame: CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, 2))
        line.image = UIImage(named: "scan_line")
        self.view.addSubview(line)
    }
    
    // MARK: Rect
    func makeScanReaderRect() -> CGRect {
        let scanSize = (min(screenWidth, screenHeight) * 3) / 5
        var scanRect = CGRectMake(0, 0, scanSize, scanSize)
        
        scanRect.origin.x += (screenWidth / 2) - (scanRect.size.width / 2)
        scanRect.origin.y += (screenHeight / 2) - (scanRect.size.height / 2)
        return scanRect
    }
    
    func makeScanReaderInterestRect() -> CGRect {
        let rect = makeScanReaderRect()
        let x = rect.origin.x / screenWidth
        let y = rect.origin.y / screenHeight
        let width = rect.size.width / screenWidth
        let height = rect.size.height / screenHeight
        
        return CGRectMake(x, y, width, height)
    }
    
    func makeScanCameraShadowView(innerRect: CGRect) -> UIView {
        let referenceImage = UIImageView(frame: self.view.bounds)
        
        UIGraphicsBeginImageContext(referenceImage.frame.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetRGBFillColor(context, 0, 0, 0, 0.3)
        var drawRect = CGRectMake(0, 0, screenWidth, screenHeight)
        CGContextFillRect(context, drawRect)
        drawRect = CGRectMake(innerRect.origin.x - referenceImage.frame.origin.x, innerRect.origin.y - referenceImage.frame.origin.y, innerRect.size.width, innerRect.size.height)
        CGContextClearRect(context, drawRect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        referenceImage.image = image
        
        return referenceImage
    }
    
    // MARK: 定时器
    
    func scanLineAnimation() {
        let rect = makeScanReaderRect()
        
        let lineFrameX = rect.origin.x
        let lineFrameY = rect.origin.y
        let downHeight = rect.size.height
        
        if upORdown == false {
            traceNumber += 1
            line.frame = CGRectMake(lineFrameX, lineFrameY + CGFloat(2 * traceNumber), downHeight, 2)
            if CGFloat(2 * traceNumber) > downHeight - 2 {
                upORdown = true
            }
        }
        else
        {
            traceNumber -= 1
            line.frame = CGRectMake(lineFrameX, lineFrameY + CGFloat(2 * traceNumber), downHeight, 2)
            if traceNumber == 0 {
                upORdown = false
            }
        }
    }
    
    // MARK: AVCaptureMetadataOutputObjectsDelegate
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        var stringValue:String?
        if metadataObjects.count > 0 {
            let metadataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            stringValue = metadataObject.stringValue
        }
        
        if let code = stringValue{
            print("code is \(code)")
            //            let alertView = UIAlertView()
            //            alertView.delegate=self
            //            alertView.title = "二维码或条形码"
            //            alertView.message = "扫到的内容为:\(code)"
            //            alertView.addButtonWithTitle("确认")
            //            alertView.show()
            do{
                try  AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
                let url = NSBundle.mainBundle().URLForResource("music", withExtension: "mp3")
                player = try AVAudioPlayer(contentsOfURL: url!)
                player.prepareToPlay()
                player.play()
                let shake = SystemSoundID(kSystemSoundID_Vibrate)
                AudioServicesPlayAlertSound(shake)
                let resultvc = ResultVC(labelstring: code)
                self.navigationController?.pushViewController(resultvc, animated: true)
                self.session.stopRunning()
            }catch  {
                print(error)
            }
        }
    }
}



