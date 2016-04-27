//
//  BannersParse.swift
//  CSolidario
//
//  Created by User on 27/4/16.
//  Copyright © 2016 iCologic. All rights reserved.
//

import UIKit
import SwiftyJSON

class BannersParse: NSObject {
    
    
    func getBannersModel(dataFromNetworking : NSData) -> [TOBannersModel]{
        var arrayBannersModel = [TOBannersModel]()
        var numberOfRows = 0
        let readableJSON = JSON(data: dataFromNetworking, options: NSJSONReadingOptions.MutableContainers, error: nil)
        numberOfRows = readableJSON["banners"].count
        if numberOfRows != 0{
            for index in 0...numberOfRows - 1{
                let dataModel = TOBannersModel(aId: getString("banners", index: index, nombre: "id", nombreObjeto: readableJSON, segundoNivel: nil),
                                               aImagenURL: getString("banners", index: index, nombre: "imagen", nombreObjeto: readableJSON, segundoNivel: nil),
                                               aOrden: getString("banners", index: index, nombre: "orden", nombreObjeto: readableJSON, segundoNivel: nil),
                                               aTitulo: getString("banners", index: index, nombre: "titulo", nombreObjeto: readableJSON, segundoNivel: nil),
                                               aTargetURL: getString("banners", index: index, nombre: "target_url", nombreObjeto: readableJSON, segundoNivel: nil))
                arrayBannersModel.append(dataModel)
            }
        }
        return arrayBannersModel
    }
    
    

}
