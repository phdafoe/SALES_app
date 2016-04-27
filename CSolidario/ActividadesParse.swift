//
//  ActividadesParse.swift
//  CSolidario
//
//  Created by User on 27/4/16.
//  Copyright © 2016 iCologic. All rights reserved.
//

import UIKit
import SwiftyJSON

class ActividadesParse: NSObject {
    
    
    func getActividadesModel(dataFromNetworking : NSData) -> [TOActividadModel]{
        var arrayActividadesModel = [TOActividadModel]()
        var numberOfRows = 0
        let readableJSON = JSON(data: dataFromNetworking, options: NSJSONReadingOptions.MutableContainers, error: nil)
        numberOfRows = readableJSON["actividades"].count
        if numberOfRows != 0{
            for index in 0...numberOfRows - 1{
                let dataModel = TOActividadModel(aId: getString("actividades", index: index, nombre: "id", nombreObjeto: readableJSON, segundoNivel: nil),
                                                 aNombre: getString("actividades", index: index, nombre: "nombre", nombreObjeto: readableJSON, segundoNivel: nil))
                arrayActividadesModel.append(dataModel)
            }
        }
        return arrayActividadesModel
    }

}
