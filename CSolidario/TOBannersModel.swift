//
//  TOBannersModel.swift
//  TusOfertas
//
//  Created by User on 18/4/16.
//  Copyright © 2016 iCologic. All rights reserved.
//

import UIKit

class TOBannersModel: NSObject {
    
    var id : String?
    var imagenURL : String?
    var orden : String?
    var titulo : String?
    var targetURL : String?
    
    init(aId : String, aImagenURL : String, aOrden : String, aTitulo : String, aTargetURL : String) {
        
        self.id = aId
        self.imagenURL = aImagenURL
        self.orden = aOrden
        self.titulo = aTitulo
        self.targetURL = aTargetURL
        super.init()
        
    }

}
