//
//  DetalleCuponesViewController
//  TusOfertas
//
//  Created by User on 16/4/16.
//  Copyright © 2016 iCologic. All rights reserved.
//

import UIKit

class DetalleCuponesViewController: UIViewController {
    
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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //showQRCuponData
        
        //showBarcodeCuponData
        
        if segue.identifier == "showQRCuponData"{
            let nav = segue.destinationViewController as! UINavigationController
            let QRCuponesVC = nav.topViewController as! QRCuponesViewController
            
            QRCuponesVC.qrData = detalleTipoOferta
            
        }
        
        if segue.identifier == "showBarcodeCuponData"{
            let nav = segue.destinationViewController as! UINavigationController
            let CBCuponesVC = nav.topViewController as! CBCuponesViewController
            
            CBCuponesVC.codeBarData = detalleTipoOferta
            
        }
        
        
        
    }
    

}
