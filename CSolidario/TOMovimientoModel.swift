//
//  TOMovimientoModel.swift
//  SidebarMenu
//
//  Created by User on 10/4/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class TOMovimientoModel: NSObject {
    

    var fecha : String?
    var puntosConseguidos : String?
    var puntosCanjeados : String?
    var nombre : String?
    
    init(aFecha : String, aNombre : String, aPuntosConseguidos : String, aPuntosCanjeados : String) {
   
            self.nombre = aNombre
            self.fecha = aFecha
            self.puntosConseguidos = aPuntosConseguidos
            self.puntosCanjeados = aPuntosCanjeados
            super.init()
    }
    

}
