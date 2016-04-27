//
//  APIDataBase.swift
//  CSolidario
//
//  Created by User on 26/4/16.
//  Copyright © 2016 iCologic. All rights reserved.
//

import UIKit
import SwiftyJSON

class AsociacionParse: NSObject {
    
    func getAsociacionesModel(dataFromNetworking : NSData) -> [TOAsociacionModel]{
        var arrayAsociacionModel = [TOAsociacionModel]()
        var numberOfRows = 0
        let readableJSON = JSON(data: dataFromNetworking, options: NSJSONReadingOptions.MutableContainers, error: nil)
        numberOfRows = readableJSON["asociaciones"].count
        if numberOfRows != 0{
            for index in 0...numberOfRows - 1{
                let dataModel = TOAsociacionModel(aId: getString("asociaciones", index: index, nombre: "id", nombreObjeto: readableJSON, segundoNivel: nil),
                aNombre: getString("asociaciones", index: index, nombre: "nombre", nombreObjeto: readableJSON, segundoNivel: nil),
                aDescripcion: getString("asociaciones", index: index, nombre: "descripcion", nombreObjeto: readableJSON, segundoNivel: nil),
                aDireccion: getString("asociaciones", index: index, nombre: "direccion", nombreObjeto: readableJSON, segundoNivel: nil),
                aIdLocalidad: getString("asociaciones", index: index, nombre: "idLocalidad", nombreObjeto: readableJSON, segundoNivel: nil),
                aImagenURL: getString("asociaciones", index: index, nombre: "logo", nombreObjeto: readableJSON, segundoNivel: nil),
                aTelefonoFijo: getString("asociaciones", index: index, nombre: "telefonoFijo", nombreObjeto: readableJSON, segundoNivel: nil),
                aTelefonoMovil: getString("asociaciones", index: index, nombre: "telefonoMovil", nombreObjeto: readableJSON, segundoNivel: nil),
                aWeb: getString("asociaciones", index: index, nombre: "web", nombreObjeto: readableJSON, segundoNivel: nil),
                aEmail: getString("asociaciones", index: index, nombre: "mail", nombreObjeto: readableJSON, segundoNivel: nil),
                aPersonaContacto: getString("asociaciones", index: index, nombre: "personaContacto", nombreObjeto: readableJSON, segundoNivel: nil))
                arrayAsociacionModel.append(dataModel)
            }
        }
        return arrayAsociacionModel
    }
    

}
