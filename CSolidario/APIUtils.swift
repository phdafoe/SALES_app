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
func getString(_ array : String, index : Int, nombre : String, nombreObjeto : JSON!, segundoNivel : String?) -> String{
    
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


func dimeString (_ json : JSON, nombre : String) -> String{
    if let stringResult = json[nombre].string{
        return stringResult
    }else{
        return ""
    }
}



func utilsDisplayAlertVCGeneral() -> UIAlertController{
    let alertVC = UIAlertController (title: CONSTANTES.TITLEDATA, message: CONSTANTES.MESSAGEDATA, preferredStyle: .alert)
    alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    return alertVC
}

func utilsDisplayAlertErrorRegistro(_ errorRegistroString : String?) -> UIAlertController{
    let alertVC = UIAlertController (title: CONSTANTES.ERRORREGISTRO, message: errorRegistroString, preferredStyle: .alert)
    alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    return alertVC
}

func utilsDisplayAlertVCExitoso() -> UIAlertController{
    let alertVC = UIAlertController (title: CONSTANTES.TITLEDATAEXITOSO, message: CONSTANTES.MESSAGEDATAEXITOSO, preferredStyle: .alert)
    alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    return alertVC
    
}

func utilsDisplayAlertVCEspaciosEnBlanco(_ errorEspaciosEnBlanco : String) -> UIAlertController{
    let alertVC = UIAlertController (title: CONSTANTES.TITLEDATA, message: errorEspaciosEnBlanco, preferredStyle: .alert)
    alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    return alertVC
    
}


