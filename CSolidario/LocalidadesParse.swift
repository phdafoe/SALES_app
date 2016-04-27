//
//  LocalidadesParse.swift
//  CSolidario
//
//  Created by User on 27/4/16.
//  Copyright © 2016 iCologic. All rights reserved.
//

import UIKit
import SwiftyJSON

class LocalidadesParse: NSObject {
    
    
    func getLocalidadesModel(dataFromNetworking : NSData) -> [TOLocalidadModel]{
        var arrayLocalidadesModel = [TOLocalidadModel]()
        var numberOfRows = 0
        let readableJSON = JSON(data: dataFromNetworking, options: NSJSONReadingOptions.MutableContainers, error: nil)
        numberOfRows = readableJSON["localidades"].count
            for index in 0...numberOfRows - 1{
                let dataModel = TOLocalidadModel(aId: getString("localidades", index: index, nombre: "id", nombreObjeto: readableJSON, segundoNivel: nil),
                                                 aNombre: getString("localidades", index: index, nombre: "nombre", nombreObjeto: readableJSON, segundoNivel: nil),
                                                 aProvincia: getString("localidades", index: index, nombre: "provincia", nombreObjeto: readableJSON, segundoNivel: nil),
                                                 aPais: getString("localidades", index: index, nombre: "pais", nombreObjeto: readableJSON, segundoNivel: nil))
                arrayLocalidadesModel.append(dataModel)
            }
        return arrayLocalidadesModel
    }

}
