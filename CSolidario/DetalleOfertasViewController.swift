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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        myImageOfertaIV.image = detalleImagenOfertaData!
        myNombreOfertaLBL.text = detalleNombreOfertaData
        myInformacionOfertaLBL.text = detalleMasInformacionData
        myFechaFinOfertaLBL.text = detalleFechaFinData
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showDataQRACTION"{
            let nav = segue.destinationViewController as! UINavigationController
            let QROfertasVC = nav.topViewController as! QROfertasViewController
            
            QROfertasVC.qrData = detalleTipoOferta
            
        }
        
        
        if segue.identifier == "showDataBarcodeACTION"{
            let nav = segue.destinationViewController as! UINavigationController
            let CBOfertasVC = nav.topViewController as! CBOfertasViewController
            
            CBOfertasVC.codeBarData = detalleTipoOferta
            
        }

    }
    
    

}
