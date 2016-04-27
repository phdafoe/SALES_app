//
//  WebDetalleViewController.swift
//  CSolidario
//
//  Created by User on 22/4/16.
//  Copyright © 2016 iCologic. All rights reserved.
//

import UIKit

class WebDetalleViewController: UIViewController {
    
    //MARK: - VARIABLES
    var detalleWebPublicidad : String?
    
    
    //MARK: - IBOUTLET
    @IBOutlet weak var myWebView: UIWebView!
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!

    
    //MARK: - IBACTION
    @IBAction func closeWindow(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string: detalleWebPublicidad!)
        let request = NSURLRequest(URL: url!)
        myWebView.loadRequest(request)
        myWebView.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}

//MARK : - UIWebViewDelegate
extension WebDetalleViewController : UIWebViewDelegate{
    
    func webViewDidStartLoad(webView: UIWebView) {
        myActivityIndicator.hidden = false
        myActivityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        myActivityIndicator.hidden = true
        myActivityIndicator.stopAnimating()
    }
    
    
}
