//
//  SetupImage.swift
//  TusOfertas
//
//  Created by User on 16/4/16.
//  Copyright © 2016 iCologic. All rights reserved.
//

import Foundation
import UIKit


open class ImageLoader{

    var cache = NSCache<AnyObject, AnyObject>()
    class var sharedLoader: ImageLoader {
        struct SingletonImage {
            static let instance : ImageLoader = ImageLoader()
        }
        return SingletonImage.instance
    }
    
    
    func imageForUrl(_ urlString : String!, completionHandler: @escaping (_ image: UIImage?, _ url: String?) -> ()){
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.background).async { () -> Void in
            let dataDownload: Data? = self.cache.object(forKey: urlString as AnyObject) as? Data
            if let goodData = dataDownload{
                let image = UIImage(data: goodData)
                DispatchQueue.main.async(execute: { () -> Void in
                    completionHandler(image, urlString)
                })
                return
            }
            
            if urlString != nil{
                let downloadTask : URLSessionDataTask = URLSession.shared.dataTask(with: URL(string: urlString)!, completionHandler: { (dataSource, response, error) -> Void in
                    
                    if error != nil{
                        
                        completionHandler(nil, urlString)
                        return
                        
                    }
                    
                    if dataSource != nil{
                        let imageDownload = UIImage(data: dataSource!)
                        self.cache.setObject(dataSource! as AnyObject, forKey: urlString as AnyObject)
                        DispatchQueue.main.async(execute: { () -> Void in
                            completionHandler(imageDownload, urlString)
                        })
                        return
                    }
                })
                downloadTask.resume()
                
            }
        }
    }
   
}
