//
//  DetalleOfertasViewController.swift
//  TusOfertas
//
//  Created by User on 16/4/16.
//  Copyright © 2016 iCologic. All rights reserved.
//

import UIKit
import CoreImage
import Parse


class DetalleOfertasViewController: UIViewController {
    
    
    var arrayBanners = [TOBannersModel]()
    var urlString : String?
    var indexActual : Int = 0
    var timer = NSTimer()
    let BANNERS = "banners"
    let BASE_BANNER_URL = "http://app.clubsinergias.es/uploads/banners"
    var qrData : String?
    var codeBarData : String?
    var qrcodeImage : CIImage!
    var imageGroupTag = 3

    
    
    //MARK: - VARIABLES LOCALES GLOBALES
    var detalleImagenOfertaData : UIImage?
    var detalleNombreOfertaData : String?
    var detalleMasInformacionData : String?
    var detalleFechaFinData : String?
    var detalleTipoOferta : String?
    
    //MARK: - VARIABLES ASOCIADO
    var detalleImagenAsociado : UIImage?
    var detallenombreAsociado : String?
    var detalleDescripcionAsociado : String?
    var detalleDireccionAsociado : String?
    var detalleCondicionesEspecialesAsociado : String?
    var detalleEmailAsociado : String?
    var detalleTelefonoFijoAsociado : String?
    var detalleTelefonoMovilAsociado : String?
    var detalleWebAsociado : String?
    
    
    
    //MARK: - IBOUTLET
    @IBOutlet weak var myImageOfertaIV: UIImageView!
    @IBOutlet weak var myNombreOfertaLBL: UILabel!
    @IBOutlet weak var myInformacionOfertaLBL: UILabel!
    @IBOutlet weak var myFechaFinOfertaLBL: UILabel!
    @IBOutlet weak var myWebViewToBanners: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myImageOfertaIV.image = detalleImagenOfertaData!
        myNombreOfertaLBL.text = detalleNombreOfertaData
        myInformacionOfertaLBL.text = detalleMasInformacionData
        myFechaFinOfertaLBL.text = detalleFechaFinData

        //BANNER
        arrayBanners = TOAPIDatabaseManager.sharedInstance.getBanners(PFUser.currentUser()!["idLocalidad"] as! String)
        runBanner()
        timer = NSTimer.scheduledTimerWithTimeInterval(60.0, target: self, selector: #selector(DetalleOfertasViewController.runBanner), userInfo: nil, repeats: true)
    }
    
    //MARK: - IBACTION
    @IBAction func showDataAsociaciones(sender: AnyObject) {
        
        let asociacionesModel = self.storyboard?.instantiateViewControllerWithIdentifier("detalleAsociaciones") as! DetalleAsociacionesViewController
        
        //PASO DE DATOS A VISTA ASOCIADO
        asociacionesModel.detalleImageAsociacionAData = detalleImagenAsociado
        asociacionesModel.detalleDescripcionData = detalleDescripcionAsociado
        asociacionesModel.detalleTelefonoFijoData = detalleTelefonoFijoAsociado
        asociacionesModel.detalleTelefonoMovilData = detalleTelefonoMovilAsociado
        asociacionesModel.detalleWebData = detalleWebAsociado
        asociacionesModel.detalleDireccionData = detalleDireccionAsociado
        asociacionesModel.detallePersonaContactoData = detallenombreAsociado
        
        self.navigationController!.pushViewController(asociacionesModel, animated: true)
    }
    
    
    @IBAction func barrasACTION(sender: AnyObject) {
        
        let background = UIView(frame: CGRectMake(0,0, self.view.frame.width, self.view.frame.height))
        background.backgroundColor = UIColor.blackColor()
        background.alpha = 0.8
        background.tag = imageGroupTag
        self.view.addSubview(background)
        
        if myNombreOfertaLBL.text != qrData{
            
            let imageView = UIImageView(frame: CGRect(x: 80, y: 150, width: self.view.frame.width / 2, height: self.view.frame.height / 3))
            imageView.contentMode = UIViewContentMode.ScaleAspectFit
            imageView.tag = imageGroupTag
            imageView.image = fromString(codeBarData!)
            self.view.addSubview(imageView)
            
        }else{
            displayAlertVC("Hola", messageData: "Tenemos problemas para genera el QR")
        }
        
        let longGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(DetalleOfertasViewController.actionGesture(_:)))
        longGestureRecognizer.minimumPressDuration = 1
        background.addGestureRecognizer(longGestureRecognizer)
    }
    
    func fromString(string : String) -> UIImage? {
        let data = string.dataUsingEncoding(NSASCIIStringEncoding)
        let filter = CIFilter(name: "CICode128BarcodeGenerator")
        filter!.setValue(data, forKey: "inputMessage")
        return UIImage(CIImage: filter!.outputImage!)
        
    }
    
    @IBAction func QRACTION(sender: AnyObject) {
        
        let background = UIView(frame: CGRectMake(0,0, self.view.frame.width, self.view.frame.height))
        background.backgroundColor = UIColor.blackColor()
        background.alpha = 0.8
        background.tag = imageGroupTag
        self.view.addSubview(background)
        
        if myNombreOfertaLBL.text != qrData{
            
            let imageView = UIImageView(frame: CGRect(x: 80, y: 150, width: self.view.frame.width / 2, height: self.view.frame.height / 3))
            imageView.contentMode = UIViewContentMode.ScaleAspectFit
            imageView.tag = imageGroupTag
            let dataQR = myNombreOfertaLBL.text?.dataUsingEncoding(NSISOLatin1StringEncoding, allowLossyConversion: false)
            let filter = CIFilter(name: "CIQRCodeGenerator")
            filter?.setValue(dataQR!, forKey: "inputMessage")
            filter?.setValue("Q", forKey: "inputCorrectionLevel")
            qrcodeImage = filter?.outputImage
            imageView.image = UIImage(CIImage: qrcodeImage)
            self.view.addSubview(imageView)
            
        }else{
            displayAlertVC("Hola", messageData: "Tenemos problemas para genera el QR")
        }
        
        let longGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(DetalleOfertasViewController.actionGesture(_:)))
        longGestureRecognizer.minimumPressDuration = 1
        background.addGestureRecognizer(longGestureRecognizer)
        
        
    }
    
    @IBAction func socioACTION(sender: AnyObject) {
        
        let background = UIView(frame: CGRectMake(0,0, self.view.frame.width, self.view.frame.height))
        background.backgroundColor = UIColor.blackColor()
        background.alpha = 0.8
        background.tag = imageGroupTag
        self.view.addSubview(background)
        
        let labelData = UILabel(frame: CGRect(x: 80, y: 150, width: 220, height: 35))
        labelData.contentMode = UIViewContentMode.ScaleAspectFit
        //labelData.backgroundColor = UIColor.whiteColor()
        labelData.textColor = UIColor.whiteColor()
        labelData.tag = imageGroupTag
        labelData.text = myNombreOfertaLBL.text
        self.view.addSubview(labelData)


        let longGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(DetalleOfertasViewController.actionGesture(_:)))
        longGestureRecognizer.minimumPressDuration = 1
        background.addGestureRecognizer(longGestureRecognizer)
    }
    
    
    @IBAction func showWeb(sender: AnyObject) {
        
        
        let webDetallePublicidad = self.storyboard?.instantiateViewControllerWithIdentifier("detalleWeb") as! WebDetalleViewController
        
        //PASO DE DATOS A VISTA ASOCIADO
        webDetallePublicidad.detalleWebPublicidad = arrayBanners[indexActual].targetURL
        self.presentViewController(webDetallePublicidad, animated: true, completion: nil)

    }
    
    
    
    
    //MARK: - GESTURE RECOGNIZER
    func actionGesture(gestureRecognizer: UIGestureRecognizer){
        for subview in self.view.subviews{
            if subview.tag == self.imageGroupTag{
                subview.removeFromSuperview()
            }
        }
    }
    
    //MARK: - ALERT TIPO
    func displayAlertVC(titleData: String, messageData: String){
        
        let alertVC = UIAlertController(title: titleData, message: messageData, preferredStyle: .Alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(alertVC, animated: true, completion: nil)
        
    }


    
    //MARK: - RUN BANNERS
    func runBanner(){
        urlString = getURL(arrayBanners[indexActual].id!, imagenURL: arrayBanners[indexActual].imagenURL!)
        let url = NSURL(string: urlString!)
        let request = NSURLRequest(URL: url!)
        myWebViewToBanners.loadRequest(request)
        print(url)
        if arrayBanners.count > indexActual + 1{
            indexActual += 1;
        } else {
            indexActual = 0;
        }
    }
    
    func getURL(id : String,  imagenURL : String) -> String{
        return BASE_BANNER_URL + "/"  + id + "/" + imagenURL
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
