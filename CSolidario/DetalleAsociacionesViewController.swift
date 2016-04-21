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
    var timer = NSTimer()
    var secondsElapsed = 0
    var pauseTimeCounting : Bool?
    
    

    //MARK: - IBOUTLET
    @IBOutlet weak var myImageAsociacionIV: UIImageView!
    @IBOutlet weak var myDescripcionLBL: UILabel!
    @IBOutlet weak var myTelefonoFijoLBL: UILabel!
    @IBOutlet weak var myTelefonoMovilLBL: UILabel!
    @IBOutlet weak var myPersonaContactoLBL: UILabel!
    @IBOutlet weak var myWebLBL: UILabel!
    @IBOutlet weak var myDireccionLBL: UILabel!
    @IBOutlet weak var myLogoIV: UIImageView!
 


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        myLogoIV.layer.cornerRadius = myLogoIV.frame.width / 16
        myLogoIV.layer.borderColor = UIColor.whiteColor().CGColor
        myLogoIV.layer.borderWidth = 1.0
        myLogoIV.layer.shadowColor = UIColor.blackColor().CGColor
        myLogoIV.layer.shadowOffset = CGSizeMake(0, 15)

        myImageAsociacionIV.image = detalleImageAsociacionAData!
        myDescripcionLBL.text = detalleDescripcionData
        myTelefonoFijoLBL.text = detalleTelefonoFijoData
        myTelefonoMovilLBL.text = detalleTelefonoMovilData
        myPersonaContactoLBL.text = detallePersonaContactoData
        myWebLBL.text = detalleWebData
        myDireccionLBL.text = detalleDireccionData
        
        self.title = detallePersonaContactoData
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}



