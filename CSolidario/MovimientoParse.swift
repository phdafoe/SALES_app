//
//  MovimientoParse.swift
//  CSolidario
//
//  Created by User on 27/4/16.
//  Copyright © 2016 iCologic. All rights reserved.
//

import UIKit
import SwiftyJSON

class MovimientoParse: NSObject {
    
    func getMovimientosModel(dataFromNetworking : NSData) -> [TOMovimientoModel]{
        var arrayMovimientoModel = [TOMovimientoModel]()
        var numberOfRows = 0
        let readableJSON = JSON(data: dataFromNetworking, options: NSJSONReadingOptions.MutableContainers, error: nil)
        numberOfRows = readableJSON["puntos"].count
        if numberOfRows != 0{
            for index in 0...numberOfRows - 1 {
                let dataModel = TOMovimientoModel(aFecha: getString("puntos", index: index, nombre: "fecha", nombreObjeto: readableJSON, segundoNivel: nil),
                aNombre: getString("puntos", index: index, nombre: "nombre", nombreObjeto: readableJSON, segundoNivel: nil),
                aPuntosConseguidos: getString("puntos", index: index, nombre: "puntosConseguidos", nombreObjeto: readableJSON, segundoNivel: nil),
                aPuntosCanjeados: getString("puntos", index: index, nombre: "puntosCanjeados", nombreObjeto: readableJSON, segundoNivel: nil))

                arrayMovimientoModel.append(dataModel)
            }
        }
        return arrayMovimientoModel
    }   

}
