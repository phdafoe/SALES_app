//
//  TOUsuarioModel.swift
//  SidebarMenu
//
//  Created by User on 10/4/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class TOUsuarioModel: NSObject {
    
    var username : String?
    var nombre : String?
    var apellidos : String?
    var email : String?
    var telefonoMovil : String?
    var idLocalidad : String?
    var asociacion : TOAsociacionModel?
    //var imagenURL : String
    var movimiento : [TOMovimientoModel]
    var parseID : String?
    var id : String?
    //var allowsGeolocation : Bool
    //var totalPuntos : Int
    
    init(aId : String, aUsername : String, aNombre : String, aApellidos : String, aEmail : String, aTelefonoMovil : String, aIdLocalidad : String, aAsociacion : TOAsociacionModel, aMovimiento : [TOMovimientoModel], aParseID : String) {

        self.username = aUsername
        self.nombre = aNombre
        self.apellidos = aApellidos
        self.email = aEmail
        self.telefonoMovil = aTelefonoMovil
        self.idLocalidad = aIdLocalidad
        self.asociacion = aAsociacion
        //self.imagenURL = aImagenURL
        self.movimiento = aMovimiento
        self.parseID = aParseID
        //self.totalPuntos = aTotalPuntos
        self.id = aId
        //self.allowsGeolocation = aAllowsGeolocation
        super.init()
    }
    
    

}
