//
//  TOActividadModel.swift
//  SidebarMenu
//
//  Created by User on 11/4/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class TOActividadModel: NSObject {
    
    var id : String?
    var nombre : String?
    
    init(aId: String, aNombre : String) {
        self.id = aId
        self.nombre = aNombre
        super.init()
        
    }

}
