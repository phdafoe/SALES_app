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
    
    func getAsociacionesModel(_ dataFromNetworking : Data) -> [TOAsociacionModel]{
        var arrayAsociacionModel = [TOAsociacionModel]()
        let readableJSON = JSON(data: dataFromNetworking, options: JSONSerialization.ReadingOptions.mutableContainers, error: nil)
            for index in readableJSON["asociaciones"]{
                let dataModel = TOAsociacionModel(aId: dimeString(index.1, nombre: "id"),
                                              aNombre: dimeString(index.1, nombre: "nombre"),
                                              aDescripcion: dimeString(index.1, nombre: "descripcion"),
                                              aDireccion: dimeString(index.1, nombre: "direccion"),
                                              aIdLocalidad: dimeString(index.1, nombre: "idLocalidad"),
                                              aImagenURL: dimeString(index.1, nombre: "logo"),
                                              aTelefonoFijo: dimeString(index.1, nombre: "telefonoFijo"),
                                              aTelefonoMovil: dimeString(index.1, nombre: "telefonoMovil"),
                                              aWeb: dimeString(index.1, nombre: "web"),
                                              aEmail: dimeString(index.1, nombre: "mail"),
                                              aPersonaContacto: dimeString(index.1, nombre: "personaContacto"))
                arrayAsociacionModel.append(dataModel)
            }
        return arrayAsociacionModel
    }

}
