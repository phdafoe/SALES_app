//
//  SetupImage.swift
//  TusOfertas
//
//  Created by User on 16/4/16.
//  Copyright © 2016 iCologic. All rights reserved.
//

import Foundation
import UIKit


public class ImageLoader{

    var cache = NSCache()
    
    class var sharedLoader: ImageLoader {
        struct SingletonImage {
            static let instance : ImageLoader = ImageLoader()
        }
        return SingletonImage.instance
    }
    
    func imageForUrl(urlString : String!, completionHandler: (image: UIImage!, url: String!) -> ()){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) { () -> Void in
            let dataDownload: NSData? = self.cache.objectForKey(urlString) as? NSData
            if let goodData = dataDownload{
                let image = UIImage(data: goodData)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    completionHandler(image: image, url: urlString)
                })
                return
            }
            
            let downloadTask : NSURLSessionDataTask = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: urlString)!, completionHandler: { (dataSource, response, error) -> Void in
                if error != nil{
                    completionHandler(image: nil, url: urlString)
                    return
                }
                if dataSource != nil{
                    let imageDownload = UIImage(data: dataSource!)
                    self.cache.setObject(dataSource!, forKey: urlString)
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        completionHandler(image: imageDownload, url: urlString)
                    })
                    return
                }
            })
            downloadTask.resume()
        }
    }

    
    
    
}
