//
//  TOAsociacionModel.swift
//  SidebarMenu
//
//  Created by User on 10/4/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class TOAsociacionModel: NSObject {
    
    var id : String?
    var nombre : String?
    var descripcion : String?
    var direccion : String?
    var idLocalidad : String?
    var imagenURL : String?
    var telefonoFijo : String?
    var telefonoMovil : String?
    var web : String?
    var email : String?
    var personaContacto : String?

    
    
    init(aId : String, aNombre : String, aDescripcion : String, aDireccion : String, aIdLocalidad : String, aImagenURL : String, aTelefonoFijo : String, aTelefonoMovil : String, aWeb : String, aEmail : String, aPersonaContacto : String) {
        
        self.id = aId
        self.nombre = aNombre
        self.descripcion = aDescripcion
        self.direccion = aDireccion
        self.idLocalidad = aIdLocalidad
        self.imagenURL = aImagenURL
        self.telefonoFijo = aTelefonoFijo
        self.telefonoMovil = aTelefonoMovil
        self.web = aWeb
        self.email = aEmail
        self.personaContacto = aPersonaContacto
        super.init()
    }

}
