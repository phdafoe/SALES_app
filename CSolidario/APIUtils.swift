//
//  APIUtils.swift
//  CSolidario
//
//  Created by User on 27/4/16.
//  Copyright © 2016 iCologic. All rights reserved.
//

import Foundation
import SwiftyJSON

let CONSTANTES = Constants()


//MARK: - GET STRING -> UTILS
func getString(array : String, index : Int, nombre : String, nombreObjeto : JSON!, segundoNivel : String?) -> String{
    
    if segundoNivel != nil{
        if let stringResult = nombreObjeto[array][index][segundoNivel!][nombre].string{
            return stringResult
        }else{
            return ""
        }
        
    }else{
        
        if let stringResult = nombreObjeto[array][index][nombre].string{
            return stringResult
        }else{
            return ""
        }
    }
}



func utilsDisplayAlertVCGeneral() -> UIAlertController{
    let alertVC = UIAlertController (title: CONSTANTES.TITLEDATA, message: CONSTANTES.MESSAGEDATA, preferredStyle: .Alert)
    alertVC.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
    return alertVC
}

func utilsDisplayAlertErrorRegistro(errorRegistroString : String?) -> UIAlertController{
    let alertVC = UIAlertController (title: CONSTANTES.ERRORREGISTRO, message: errorRegistroString, preferredStyle: .Alert)
    alertVC.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
    return alertVC
}

func utilsDisplayAlertVCExitoso() -> UIAlertController{
    let alertVC = UIAlertController (title: CONSTANTES.TITLEDATAEXITOSO, message: CONSTANTES.MESSAGEDATAEXITOSO, preferredStyle: .Alert)
    alertVC.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
    return alertVC
    
}

func utilsDisplayAlertVCEspaciosEnBlanco(errorEspaciosEnBlanco : String) -> UIAlertController{
    let alertVC = UIAlertController (title: CONSTANTES.TITLEDATA, message: errorEspaciosEnBlanco, preferredStyle: .Alert)
    alertVC.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
    return alertVC
    
}


