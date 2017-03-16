//
//  APIConstantesManager.swift
//  CSolidario
//
//  Created by User on 25/4/16.
//  Copyright © 2016 iCologic. All rights reserved.
//

import Foundation
import Parse

struct Constants {
    
    let OFERTAS = "oferta"
    let CUPONES = "cupon"
    let CONCURSO = "concurso"
    let BASE_PHOTO_URL = "http://app.clubsinergias.es/uploads/promociones/"

    let BASE_URL = "https://app.clubsinergias.es/api_comercios.php"
    let PROMOCIONES_SERVICE = "promociones"
    let ACTIVIDADES_SERVICE = "actividades"
    let ASOCIACIONES_SERVICE = "asociaciones"
    let MOVIMIENTOS_SERVICE = "movimientos"
    
    let BANNERS_SERVICE = "banners"
    let LOCALIDADES_SERVICE = "localidades"
    let PUNTOS_SERVICE = "puntos"
    let NUEVOCLIENTE_SERVICE = "nuevocliente"
    let ASOCIADOS_SERVICE = "asociados"
    
    let ASOCIACIONES_IMAGENES = "asociaciones"
    let BASE_PHOTO_URL_ASOCIACIONES = "http://app.clubsinergias.es/uploads/"
    
    let BASE_BANNER_URL = "http://app.clubsinergias.es/uploads/banners"
    
    let IDLOCALIDAD = "idLocalidad"
    let IDASOCIACION = "asociacion"
    let IDNOMBRE = "nombre"
    let IDAPELLIDOS = "apellidos"
    let IDTELEFONOMOVIL = "telefonoMovil"
    let IDMAIL = "email"
    let IDIMAGENURL = "imagenFile"
    let IDNOMBRETABLAIMAGEN = "ImageProfile"
    
    let IDLOCALIZACIONPARSE = "lastLocation"
    let IDDATABASEID = "databaseID"
    let ERRORREGISTRO = "Error al registrar el Usuario"
    let ERRORESPACIOSENBLANCO = "Por favor rellena todos los campos obligatorios, muchas gracias"
    
    let USERNAMEPARSE = "username"
    
    let BASEURLIDPARSE = "http://app.clubsinergias.es/api_comercios.php?idparse="
    let BASEURLIDLOCALIDAD = "http://app.clubsinergias.es/api_comercios.php?idlocalidad="
    let BASEURLIDCLIENTE = "http://app.clubsinergias.es/api_comercios.php?idcliente="
    let BASEIDP = "&p="
    let BASEIDTIPO = "&tipo="
    
    //let PFUSERIDLOCALIDAD = PFUser.currentUser()!["idLocalidad"] as! String
    
    let TITLEDATA = "Atención"
    let MESSAGEDATA = "Por favor revise toda la información"
    
    let TITLEDATAEXITOSO = "Atención"
    let MESSAGEDATAEXITOSO = "La información se ha subido correctamente"
    
    
}


