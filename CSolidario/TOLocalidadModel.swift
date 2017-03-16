//
//  TOLocalidadModel.swift
//  SidebarMenu
//
//  Created by User on 11/4/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class TOLocalidadModel: NSObject {
    
    var id : String?
    var nombre : String?
    var provincia : String?
    var pais : String?
    

    
    init(aId : String, aNombre : String, aProvincia : String, aPais : String) {
        self.id = aId
        self.nombre = aNombre
        self.provincia = aProvincia
        self.pais = aPais
        super.init()
    }

}
