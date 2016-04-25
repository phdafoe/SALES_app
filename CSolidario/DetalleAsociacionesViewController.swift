//
//  DetalleAsociacionesViewController.swift
//  TusOfertas
//
//  Created by User on 16/4/16.
//  Copyright © 2016 iCologic. All rights reserved.
//

import UIKit
import Parse


class DetalleAsociacionesViewController: UIViewController {

    
    //MARK: - VARIABLES LOCALES
    var detalleImageAsociacionAData : UIImage?
    var detalleDescripcionData : String?
    var detalleTelefonoFijoData : String?
    var detalleTelefonoMovilData : String?
    var detallePersonaContactoData : String?
    var detalleWebData : String?
    var detalleDireccionData : String?
    
    
    //MARK: - VARIABLES BANNER
    var arrayBanners = [TOBannersModel]()
    var urlString : String?
    var indexActual : Int = 0
    var timer = NSTimer()
    let CONSTANTES = Constants()
    
    

    //MARK: - IBOUTLET
    @IBOutlet weak var myImageAsociacionIV: UIImageView!
    @IBOutlet weak var myTelefonoFijoLBL: UILabel!
    @IBOutlet weak var myTelefonoMovilLBL: UILabel!
    @IBOutlet weak var myPersonaContactoLBL: UILabel!
    @IBOutlet weak var myWebLBL: UILabel!
    @IBOutlet weak var myDireccionLBL: UILabel!
    @IBOutlet weak var myLogoIV: UIImageView!
    @IBOutlet weak var myWebGifPublicidad: UIWebView!
    @IBOutlet weak var myDescripcionTV: UITextView!
    
    
    //MARK: - IBACTION
    
    @IBAction func showWebPublicidad(sender: AnyObject) {
        
        let webDetallePublicidad = self.storyboard?.instantiateViewControllerWithIdentifier("detalleWeb") as! WebDetalleViewController
        
        //PASO DE DATOS A VISTA ASOCIADO
        webDetallePublicidad.detalleWebPublicidad = arrayBanners[indexActual].targetURL
        self.presentViewController(webDetallePublicidad, animated: true, completion: nil)
        
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        myLogoIV.layer.cornerRadius = myLogoIV.frame.width / 16
        myLogoIV.layer.borderColor = UIColor(red: 0.71, green: 0.75, blue: 0.20, alpha: 1.0).CGColor
        myLogoIV.layer.borderWidth = 1.5
        myLogoIV.layer.shadowColor = UIColor.blackColor().CGColor
        myLogoIV.layer.shadowOffset = CGSizeMake(0, 15)
        


        myImageAsociacionIV.image = detalleImageAsociacionAData!
        myDescripcionTV.text = detalleDescripcionData
        myTelefonoFijoLBL.text = detalleTelefonoFijoData
        myTelefonoMovilLBL.text = detalleTelefonoMovilData
        myPersonaContactoLBL.text = detallePersonaContactoData
        myWebLBL.text = detalleWebData
        myDireccionLBL.text = detalleDireccionData
        
        self.title = detallePersonaContactoData
        
        
        //BANNER
        arrayBanners = TOAPIDatabaseManager.sharedInstance.getBanners(PFUser.currentUser()!["idLocalidad"] as! String)
        runBanner()
        timer = NSTimer.scheduledTimerWithTimeInterval(60.0, target: self, selector: #selector(DetalleOfertasViewController.runBanner), userInfo: nil, repeats: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - RUN BANNERS
    func runBanner(){
        urlString = getURL(arrayBanners[indexActual].id!, imagenURL: arrayBanners[indexActual].imagenURL!)
        let url = NSURL(string: urlString!)
        let request = NSURLRequest(URL: url!)
        myWebGifPublicidad.loadRequest(request)
        print(url)
        if arrayBanners.count > indexActual + 1{
            indexActual += 1;
        } else {
            indexActual = 0;
        }
    }
    
    func getURL(id : String,  imagenURL : String) -> String{
        return CONSTANTES.BASE_BANNER_URL + "/"  + id + "/" + imagenURL
        
    }


}



