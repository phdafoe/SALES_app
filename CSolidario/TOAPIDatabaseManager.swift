//
//  TOAPIDatabaseManager.swift
//  
//
//  Created by User on 15/4/16.
//
//

import UIKit
import SwiftyJSON
import Parse

//Promociones OK
//Asociaciones OK
//Movimientos OK

//Localidades
//Actividades
//Banners

class TOAPIDatabaseManager: NSObject {

    //MARK: - VARIABLES LOCALES
    var numberOfRows = 0
    var json : JSON = JSON.null
    
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
    
 

    
    //MARK: - SINGLETON
    class var sharedInstance : TOAPIDatabaseManager {
        
        struct SingletonAPP {
            
            static let instancia = TOAPIDatabaseManager()
        }
        return SingletonAPP.instancia
    }
    
    
    //MARK: - GET PROMOCIONES
    func getPromociones(idLocalidad : String, tipo : String) -> [TOPromocionModel]{
        
        print("HAS ENTRADO A PROMOCIONES")
        
        let idLocalidad = PFUser.currentUser()!["idLocalidad"] as! String
        
        var arrayPromocionModel = [TOPromocionModel]()
        let url = NSURL(string: "http://app.clubsinergias.es/api_comercios.php?idlocalidad=" + idLocalidad + "&tipo=" + tipo + "&p=" + PROMOCIONES_SERVICE)
        let jsonData = NSData(contentsOfURL: url!)
        let readableJSON = JSON(data: jsonData!, options: NSJSONReadingOptions.MutableContainers, error: nil)
        
        numberOfRows = readableJSON["promociones"].count

        for index in 0...numberOfRows - 1{
            
            let toAsociadoModel = TOAsociadoModel(aId: getString("promociones", index: index, nombre: "id", nombreObjeto: readableJSON, segundoNivel: "asociado"),
                                                  aNombre:getString("promociones", index: index, nombre: "nombre", nombreObjeto: readableJSON, segundoNivel: "asociado"),
                                                  aIdActividad: getString("promociones", index: index, nombre: "idActividad", nombreObjeto: readableJSON, segundoNivel: "asociado"),
                                                  aIdLocalidad: getString("promociones", index: index, nombre: "idLocalidad", nombreObjeto: readableJSON, segundoNivel: "asociado"),
                                                  aDescripcion: getString("promociones", index: index, nombre: "descripcion", nombreObjeto: readableJSON, segundoNivel: "asociado"),
                                                  aDireccion: getString ("promociones", index: index, nombre: "direccion", nombreObjeto: readableJSON, segundoNivel: "asociado"),
                                                  aCondicionesEspeciales: getString("promociones", index: index, nombre: "condicionesEspeciales", nombreObjeto: readableJSON, segundoNivel: "asociado"),
                                                  aEmail: getString("promociones", index: index, nombre: "mail", nombreObjeto: readableJSON, segundoNivel: "asociado"),
                                                  aImagenURL: getString("promociones", index: index, nombre: "imagen", nombreObjeto: readableJSON, segundoNivel: "asociado"),
                                                  aTelefonoFijo: getString("promociones", index: index, nombre: "telefonoFijo", nombreObjeto: readableJSON, segundoNivel: "asociado"),
                                                  aTelefonoMovil: getString("promociones", index: index, nombre: "telefonoMovil", nombreObjeto: readableJSON, segundoNivel: "asociado"),
                                                  aWeb: getString("promociones", index: index, nombre: "web", nombreObjeto: readableJSON, segundoNivel: "asociado"))
            
            let dataModel = TOPromocionModel(aImagenURL:getString("promociones", index: index, nombre: "imagen", nombreObjeto: readableJSON, segundoNivel: nil),
                                             aTitulo:getString("promociones", index: index, nombre: "nombre", nombreObjeto: readableJSON, segundoNivel: nil),
                                             aDescripcion:getString("promociones", index: index, nombre: "masInformacion", nombreObjeto: readableJSON, segundoNivel: nil),
                                             aAsociado:toAsociadoModel,
                                             aId:getString("promociones", index: index, nombre: "id", nombreObjeto: readableJSON, segundoNivel: nil),
                                             aFechaValidez:getString("promociones", index: index, nombre: "fechaFin", nombreObjeto: readableJSON, segundoNivel: nil),
                                             aTipo:getString("promociones", index: index, nombre: "tipoPromocion", nombreObjeto: readableJSON, segundoNivel: nil))
            
            arrayPromocionModel.append(dataModel)
        }
        return arrayPromocionModel
        
    }
    
    
    //MARK: - GET ASOCIACIONES
    func getAsociaciones(idlocalidad : String) -> [TOAsociacionModel]{
        
        var arrayAsociacionModel = [TOAsociacionModel]()
        
        
        let url = NSURL(string: "http://app.clubsinergias.es/api_comercios.php?idlocalidad=" + idlocalidad + "&p=" + ASOCIACIONES_SERVICE)
        let jsonData = NSData(contentsOfURL: url!)
        let readableJSON = JSON(data: jsonData!, options: NSJSONReadingOptions.MutableContainers, error: nil)
        
        numberOfRows = readableJSON["asociaciones"].count
        
        for index in 0...numberOfRows - 1{

            let dataModel = TOAsociacionModel(aId: getString("asociaciones", index: index, nombre: "id", nombreObjeto: readableJSON, segundoNivel: nil),
                                              aNombre: getString("asociaciones", index: index, nombre: "nombre", nombreObjeto: readableJSON, segundoNivel: nil),
                                              aDescripcion: getString("asociaciones", index: index, nombre: "descripcion", nombreObjeto: readableJSON, segundoNivel: nil),
                                              aDireccion: getString("asociaciones", index: index, nombre: "direccion", nombreObjeto: readableJSON, segundoNivel: nil),
                                              aIdLocalidad: getString("asociaciones", index: index, nombre: "idLocalidad", nombreObjeto: readableJSON, segundoNivel: nil),
                                              aImagenURL: getString("asociaciones", index: index, nombre: "logo", nombreObjeto: readableJSON, segundoNivel: nil),
                                              aTelefonoFijo: getString("asociaciones", index: index, nombre: "telefonoFijo", nombreObjeto: readableJSON, segundoNivel: nil),
                                              aTelefonoMovil: getString("asociaciones", index: index, nombre: "telefonoMovil", nombreObjeto: readableJSON, segundoNivel: nil),
                                              aWeb: getString("asociaciones", index: index, nombre: "web", nombreObjeto: readableJSON, segundoNivel: nil),
                                              aEmail: getString("asociaciones", index: index, nombre: "mail", nombreObjeto: readableJSON, segundoNivel: nil),
                                              aPersonaContacto: getString("asociaciones", index: index, nombre: "personaContacto", nombreObjeto: readableJSON, segundoNivel: nil))
            
            arrayAsociacionModel.append(dataModel)
        }
        
        return arrayAsociacionModel
    }
    
    
    
    
    //AQUI TENGO QUE GESTIONAR EL VALOR NIL OJO
    //MARK: - GET MOVIMIENTOS
    func  getMovimientos(idCliente : String) -> [TOMovimientoModel]{


        var arrayMovimientoModel = [TOMovimientoModel]()
        let url = NSURL(string: "http://app.clubsinergias.es/api_comercios.php?idcliente=" + idCliente + "&p=" + PUNTOS_SERVICE)
        let jsonData = NSData(contentsOfURL: url!)
        let readableJSON = JSON(data: jsonData!, options: NSJSONReadingOptions.MutableContainers, error: nil)
        
        numberOfRows = readableJSON["puntos"].count

        for index in 0...numberOfRows - 1 {
            
            let dataModel = TOMovimientoModel(aFecha: getString("puntos", index: index, nombre: "fecha", nombreObjeto: readableJSON, segundoNivel: nil),
                                              aNombre: getString("puntos", index: index, nombre: "nombre", nombreObjeto: readableJSON, segundoNivel: nil),
                                              aPuntosConseguidos: getString("puntos", index: index, nombre: "puntosConseguidos", nombreObjeto: readableJSON, segundoNivel: nil),
                                              aPuntosCanjeados: getString("puntos", index: index, nombre: "puntosCanjeados", nombreObjeto: readableJSON, segundoNivel: nil))
            
            
            arrayMovimientoModel.append(dataModel)
        }
        
        return arrayMovimientoModel
    }
    
    
    

    //MARK: - GET LOCALIDADES
    func getLocalidades() -> [TOLocalidadModel]{
        
        var arrayLocalidadesModel = [TOLocalidadModel]()

        let url = NSURL(string: "http://app.clubsinergias.es/api_comercios.php?idlocalidad=" + "&p=" + LOCALIDADES_SERVICE)
        let jsonData = NSData(contentsOfURL: url!)
        let readableJSON = JSON(data: jsonData!, options: NSJSONReadingOptions.MutableContainers, error: nil)
        
        numberOfRows = readableJSON["localidades"].count
        
        for index in 0...numberOfRows - 1{
            
            let dataModel = TOLocalidadModel(aId: getString("localidades", index: index, nombre: "id", nombreObjeto: readableJSON, segundoNivel: nil),
                                             aNombre: getString("localidades", index: index, nombre: "nombre", nombreObjeto: readableJSON, segundoNivel: nil),
                                             aProvincia: getString("localidades", index: index, nombre: "provincia", nombreObjeto: readableJSON, segundoNivel: nil),
                                             aPais: getString("localidades", index: index, nombre: "pais", nombreObjeto: readableJSON, segundoNivel: nil))
            
            
            arrayLocalidadesModel.append(dataModel)
        }
        
        return arrayLocalidadesModel
    }
    
    
    
    //MARK: - GET ACTIVIDADES
    func getActividades() -> [TOActividadModel]{
        
        var arrayActividadesModel = [TOActividadModel]()
        
        let url = NSURL(string: "http://app.clubsinergias.es/api_comercios.php?idlocalidad=" + "&p=" + ACTIVIDADES_SERVICE)
        let jsonData = NSData(contentsOfURL: url!)
        let readableJSON = JSON(data: jsonData!, options: NSJSONReadingOptions.MutableContainers, error: nil)
        
        
        numberOfRows = readableJSON["actividades"].count
        
        for index in 0...numberOfRows - 1{
            
            let dataModel = TOActividadModel(aId: getString("actividades", index: index, nombre: "id", nombreObjeto: readableJSON, segundoNivel: nil),
                                             aNombre: getString("actividades", index: index, nombre: "nombre", nombreObjeto: readableJSON, segundoNivel: nil))
            
            
            arrayActividadesModel.append(dataModel)
        }
        
        return arrayActividadesModel
    }
    
    
    //MARK: - GET BANNERS
    func getBanners(idlocalidad : String) -> [TOBannersModel]{
        //Esto hay que borrarlo
        let idlocalidad = PFUser.currentUser()!["idLocalidad"] as! String
        //Esto hay que borrarlo
        var arrayBannersModel = [TOBannersModel]()
        
        let url = NSURL(string: "http://app.clubsinergias.es/api_comercios.php?idlocalidad=" + idlocalidad + "&p=" + BANNERS_SERVICE)
        let jsonData = NSData(contentsOfURL: url!)
        let readableJSON = JSON(data: jsonData!, options: NSJSONReadingOptions.MutableContainers, error: nil)
        
        numberOfRows = readableJSON["banners"].count
        
        for index in 0...numberOfRows - 1{
            
            let dataModel = TOBannersModel(aId: getString("banners", index: index, nombre: "id", nombreObjeto: readableJSON, segundoNivel: nil),
                                           aImagenURL: getString("banners", index: index, nombre: "imagen", nombreObjeto: readableJSON, segundoNivel: nil),
                                           aOrden: getString("banners", index: index, nombre: "orden", nombreObjeto: readableJSON, segundoNivel: nil),
                                           aTitulo: getString("banners", index: index, nombre: "titulo", nombreObjeto: readableJSON, segundoNivel: nil),
                                           aTargetURL: getString("banners", index: index, nombre: "target_url", nombreObjeto: readableJSON, segundoNivel: nil))
            
            arrayBannersModel.append(dataModel)
        }
        return arrayBannersModel
    }
    
    
    //MARK: - GET SAVEUSER
    func getSaveUser(parseID : String) -> String{
        
        let url = NSURL(string: "http://app.clubsinergias.es/api_comercios.php?parseid=" + parseID + "&p=" + NUEVOCLIENTE_SERVICE)
        let id = NSData(contentsOfURL: url!)
        return String(id)
  
    }

    
    //MARK: - GET STRING -> UTILS
    func getString(array : String, index : Int, nombre : String, nombreObjeto : JSON!, segundoNivel : String?) -> String{
        
        if segundoNivel != nil{
            if let stringResult = nombreObjeto[array][index][segundoNivel!][nombre].string{
                return stringResult
            }else{
                return ""
            }
            
        }else{
            
            if let stringResult = nombreObjeto[array][index][nombre].string{
                return stringResult
            }else{
                return ""
            }
        }
    }
    
    
}
