//
//  PromocionesParse.swift
//  CSolidario
//
//  Created by User on 27/4/16.
//  Copyright © 2016 iCologic. All rights reserved.
//

import UIKit
import SwiftyJSON

class PromocionesParse: NSObject {
    
    
    func getPromocionesModel(_ dataFromNetworking : Data) -> [TOPromocionModel]{
        
        var arrayPromocionModel = [TOPromocionModel]()
        var numberOfRows = 0
        let readableJSON = JSON(data: dataFromNetworking, options: JSONSerialization.ReadingOptions.mutableContainers, error: nil)
        print(readableJSON)
        numberOfRows = readableJSON["promociones"].count
        if numberOfRows != 0{
            for index in 0...numberOfRows - 1{
                let toAsociadoModel = TOAsociadoModel(aId: getString("promociones", index: index, nombre: "id", nombreObjeto: readableJSON, segundoNivel: "asociado"),
                                                      aNombre:getString("promociones", index: index, nombre: "nombre", nombreObjeto: readableJSON, segundoNivel: "asociado"),
                                                      aIdActividad: getString("promociones", index: index, nombre: "idActividad", nombreObjeto: readableJSON, segundoNivel: "asociado"),
                                                      aIdLocalidad: getString("promociones", index: index, nombre: "idLocalidad", nombreObjeto: readableJSON, segundoNivel: "asociado"),
                                                      aDescripcion: getString("promociones", index: index, nombre: "descripcion", nombreObjeto: readableJSON, segundoNivel: "asociado"),
                                                      aDireccion: getString ("promociones", index: index, nombre: "direccion", nombreObjeto: readableJSON, segundoNivel: "asociado"),
                                                      aCondicionesEspeciales: getString("promociones", index: index, nombre: "condicionesEspeciales", nombreObjeto: readableJSON, segundoNivel: "asociado"),
                                                      aEmail: getString("promociones", index: index, nombre: "mail", nombreObjeto: readableJSON, segundoNivel: "asociado"),
                                                      aImagenURL: getString("promociones", index: index, nombre: "imagen", nombreObjeto: readableJSON, segundoNivel: "asociado"),
                                                      aTelefonoFijo: getString("promociones", index: index, nombre: "telefonoFijo", nombreObjeto: readableJSON, segundoNivel: "asociado"),
                                                      aTelefonoMovil: getString("promociones", index: index, nombre: "telefonoMovil", nombreObjeto: readableJSON, segundoNivel: "asociado"),
                                                      aWeb: getString("promociones", index: index, nombre: "web", nombreObjeto: readableJSON, segundoNivel: "asociado"))
                
                let dataModel = TOPromocionModel(aImagenURL:getString("promociones", index: index, nombre: "imagen", nombreObjeto: readableJSON, segundoNivel: nil),
                                                 aTitulo:getString("promociones", index: index, nombre: "nombre", nombreObjeto: readableJSON, segundoNivel: nil),
                                                 aDescripcion:getString("promociones", index: index, nombre: "masInformacion", nombreObjeto: readableJSON, segundoNivel: nil),
                                                 aAsociado:toAsociadoModel,
                                                 aId:getString("promociones", index: index, nombre: "id", nombreObjeto: readableJSON, segundoNivel: nil),
                                                 aFechaValidez:getString("promociones", index: index, nombre: "fechaFin", nombreObjeto: readableJSON, segundoNivel: nil),
                                                 aTipo:getString("promociones", index: index, nombre: "tipoPromocion", nombreObjeto: readableJSON, segundoNivel: nil))
                arrayPromocionModel.append(dataModel)
            }
        }
        return arrayPromocionModel
    }

}
