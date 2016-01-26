//
//  URLService.swift
//  HeYueMerchant
//
//  Created by 王玉琨 on 16/1/1.
//  Copyright © 2016年 王玉琨. All rights reserved.
//

import Foundation



/*

    internal enum HttpMethod{
        case GET,POST
    }
    func RequestWithParameters(BaseURL:String,Parameter:String,httpMethod:HttpMethod,callback:(ANYOBJ:AnyObject)->Void){
        let request : NSMutableURLRequest
        switch httpMethod{
        case .GET :
            request = NSMutableURLRequest(URL: NSURL(string: BaseURL+"?"+Parameter)!)
            request.HTTPMethod = "GET"
            
        case .POST :
            request = NSMutableURLRequest(URL: NSURL(string: BaseURL)!)
            request.HTTPMethod = "POST"
            let NSParameter = Parameter as NSString
            let PostParameter = NSParameter.dataUsingEncoding(NSUTF8StringEncoding)
            request.HTTPBody = PostParameter!
        }
        request.timeoutInterval = 5
        let session = NSURLSession.sharedSession()
        let semaphroe = dispatch_semaphore_create(0)
        let dataTask = session.dataTaskWithRequest(request, completionHandler: { (fromdata, fromresponse, fromerror) -> Void in
            if fromresponse == nil {
                print("连接超时，请检查你的网络")
                callback(ANYOBJ: -1)
            }else{
                let res = fromresponse as! NSHTTPURLResponse
                if res.statusCode == 200{
                    do{
                        if let data = fromdata{
                            let data = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
                            callback(ANYOBJ: data)
                        }
                    }catch let error as NSError{
                        print(error)
                    }
                }else{
                    
                }
                dispatch_semaphore_signal(semaphroe)
            }}) as NSURLSessionTask
        dataTask.resume()
        dispatch_semaphore_wait(semaphroe, DISPATCH_TIME_FOREVER)
    }
    
    
    func RequestWithNil(BaseURL:String,httpMethod:HttpMethod,callback:(ANYOBJ:AnyObject)->Void){
        let request : NSMutableURLRequest
        switch httpMethod{
        case .GET :
            request = NSMutableURLRequest(URL: NSURL(string: BaseURL)!)
            request.HTTPMethod = "GET"
            
        case .POST :
            request = NSMutableURLRequest(URL: NSURL(string: BaseURL)!)
            request.HTTPMethod = "POST"
        }
        request.timeoutInterval = 5
        let session = NSURLSession.sharedSession()
        let semaphroe = dispatch_semaphore_create(0)
        let dataTask = session.dataTaskWithRequest(request, completionHandler: { (fromdata, fromresponse, fromerror) -> Void in
            if fromresponse == nil {
                print("连接超时，请检查你的网络")
                callback(ANYOBJ: -1)
            }else{
                let res = fromresponse as! NSHTTPURLResponse
                if res.statusCode == 200{
                    do{
                        if let data = fromdata{
                            let data = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
                            callback(ANYOBJ: data)
                        }
                    }catch let error as NSError{
                        print(error)
                    }
                }else{
                    
                }
                dispatch_semaphore_signal(semaphroe)
            }}) as NSURLSessionTask
        dataTask.resume()
        dispatch_semaphore_wait(semaphroe, DISPATCH_TIME_FOREVER)
    }
    
    */


