//
//  QROfertasViewController.swift
//  TusOfertas
//
//  Created by User on 17/4/16.
//  Copyright © 2016 iCologic. All rights reserved.
//

import UIKit
import Parse


class QROfertasViewController: UIViewController {

    
    //MARK: - VARIABLES LOCALES
    var qrData : String?
    var qrcodeImage : CIImage!
    
    var arrayBanners = [TOBannersModel]()
    var timer = NSTimer()
    let GIF_HEIGHT = 200;
    let GIF_WIDHT = 720;
    let BANNERS = "banners"
    let BASE_BANNER_URL = "http://app.clubsinergias.es/uploads/banners"


    //Button button;
    var actualPosition = 0;
    
    //MARK: - IBOUTLET
    @IBOutlet weak var myQRDataLabelLBL: UILabel!
    @IBOutlet weak var myQRDataImageViewIV: UIImageView!
    @IBOutlet weak var myQRDataButton: UIButton!
    
    
    @IBOutlet weak var myBannerWebView: UIWebView!
    
    
    
    //MARK: - IBACTION
    @IBAction func generaCodigoQRACTION(sender: AnyObject) {
        
        if qrcodeImage == nil{
            
            if myQRDataLabelLBL.text == qrData{

                let dataQR = myQRDataLabelLBL.text?.dataUsingEncoding(NSISOLatin1StringEncoding, allowLossyConversion: false)
                let filter = CIFilter(name: "CIQRCodeGenerator")
                filter?.setValue(dataQR!, forKey: "inputMessage")
                filter?.setValue("Q", forKey: "inputCorrectionLevel")
                qrcodeImage = filter?.outputImage
                myQRDataImageViewIV.image = UIImage(CIImage: qrcodeImage)
                
            }else{
                displayAlertVC("Hola", messageData: "Tenemos problemas para genera el QR")
            }
            
        }else{
            
            displayAlertVC("Hola", messageData: "Tenemos problemas para genera el QR ahora mismo")
        }
    }
    
    
    @IBAction func hiddeViewController(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        myQRDataLabelLBL.text = qrData
        myQRDataLabelLBL.textColor = UIColor.whiteColor()
        self.title = "Escaner Código Qr"
        
        //BANNER
        arrayBanners = TOAPIDatabaseManager.sharedInstance.getBanners(PFUser.currentUser()!["idLocalidad"] as! String)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: #selector(QROfertasViewController.runBanner), userInfo: nil, repeats: true)
        
    }
    
    func runBanner(){

        let url = NSURL(string: "https://media.giphy.com/media/10juQ7fAaQjuHS/giphy.gif")
        let request = NSURLRequest(URL: url!)
        myBannerWebView.loadRequest(request)
        
        print(url)

        
        if arrayBanners.count > actualPosition + 1{
            actualPosition += 1;
        } else {
            actualPosition = 0;
        }
        
    }
    
    func getURL( imagenURL : String) -> String{
        
        return BASE_BANNER_URL + "/" + imagenURL
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func displayAlertVC(titleData: String, messageData: String){
        
        let alertVC = UIAlertController(title: titleData, message: messageData, preferredStyle: .Alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(alertVC, animated: true, completion: nil)
        
    }
    
    


}
