//
//  TOAsociadoModel.swift
//  SidebarMenu
//
//  Created by User on 10/4/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class TOAsociadoModel: NSObject {
    
    var id : String?
    var nombre : String?
    var idActividad : String?
    var idLocalidad : String?
    var descripcion : String?
    var direccion : String?
    var condicionesEspeciales : String?
    var email : String?
    var imagenURL : String?
    var telefonoFijo : String?
    var telefonoMovil : String?
    var web : String?

    
    init(aId : String, aNombre : String, aIdActividad : String, aIdLocalidad : String, aDescripcion : String, aDireccion : String, aCondicionesEspeciales : String, aEmail : String, aImagenURL : String, aTelefonoFijo : String, aTelefonoMovil : String, aWeb : String) {
        
        self.id = aId
        self.nombre = aNombre
        self.idActividad = aIdActividad
        self.idLocalidad = aIdLocalidad
        self.descripcion = aDescripcion
        self.direccion = aDireccion
        self.condicionesEspeciales = aCondicionesEspeciales
        self.email = aEmail
        self.imagenURL = aImagenURL
        self.telefonoFijo = aTelefonoFijo
        self.telefonoMovil = aTelefonoMovil
        self.web = aWeb
        super.init()
        
        
    }
    

}
