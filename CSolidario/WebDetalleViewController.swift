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
    @IBAction func closeWindow(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: detalleWebPublicidad!)
        let request = URLRequest(url: url!)
        myWebView.loadRequest(request)
        myWebView.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}

//MARK : - UIWebViewDelegate
extension WebDetalleViewController : UIWebViewDelegate{
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        myActivityIndicator.isHidden = false
        myActivityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        myActivityIndicator.isHidden = true
        myActivityIndicator.stopAnimating()
    }
    
    
}
