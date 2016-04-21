//
//  QRCuponesViewController
//  TusOfertas
//
//  Created by User on 17/4/16.
//  Copyright © 2016 iCologic. All rights reserved.
//

import UIKit

class QRCuponesViewController: UIViewController {

    
    //MARK: - VARIABLES LOCALES
    var qrData : String?
    var qrcodeImage : CIImage!
    
    //MARK: - IBOUTLET
    @IBOutlet weak var myQRDataLabelLBL: UILabel!
    @IBOutlet weak var myQRDataImageViewIV: UIImageView!
    @IBOutlet weak var myQRDataButton: UIButton!

    
    
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
                displayAlertVC("Hola", messageData: "Tenemos problemas para genera el QR")            }
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
        self.title = "Escaner Código QR"
        
        //self.title = qrData

        // Do any additional setup after loading the view.
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
