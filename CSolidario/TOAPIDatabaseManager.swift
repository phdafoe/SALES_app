//
//  TOAPIDatabaseManager.swift
//  
//
//  Created by User on 15/4/16.
//
//

import UIKit

class TOAPIDatabaseManager: NSObject {

    //MARK: - VARIABLES LOCALES
    let CONSTANTES = Constants()
    let asociaciones = AsociacionParse()
    let movimientos = MovimientoParse()
    let localidades = LocalidadesParse()
    let actividades = ActividadesParse()
    let banners = BannersParse()
    let promociones = PromocionesParse()

    //MARK: - SINGLETON
    class var sharedInstance : TOAPIDatabaseManager {
        struct SingletonAPP {
            static let instancia = TOAPIDatabaseManager()
        }
        return SingletonAPP.instancia
    }

    //MARK: - GET PROMOCIONES
    func getPromociones(idLocalidad : String, tipo : String) -> [TOPromocionModel]{

        let idLocalidad = CONSTANTES.PFUSERIDLOCALIDAD
        let url = NSURL(string: CONSTANTES.BASEURLIDLOCALIDAD + idLocalidad + CONSTANTES.BASEIDTIPO + tipo + CONSTANTES.BASEIDP + CONSTANTES.PROMOCIONES_SERVICE)
        let jsonData = NSData(contentsOfURL: url!)
        let arrayPromocionModel = promociones.getPromocionesModel(jsonData!)
        return arrayPromocionModel
        
    }
    
    //MARK: - GET ASOCIACIONES
    func getAsociaciones(idlocalidad : String) -> [TOAsociacionModel]{
        
        let url = NSURL(string: CONSTANTES.BASEURLIDLOCALIDAD + idlocalidad + CONSTANTES.BASEIDP + CONSTANTES.ASOCIACIONES_SERVICE)
        let jsonData = NSData(contentsOfURL: url!)
        let arrayAsociones =  asociaciones.getAsociacionesModel(jsonData!)
        return arrayAsociones
    }

    //MARK: - GET MOVIMIENTOS
    func  getMovimientos(idCliente : String) -> [TOMovimientoModel]{

        let url = NSURL(string: CONSTANTES.BASEURLIDCLIENTE + idCliente + CONSTANTES.BASEIDP + CONSTANTES.PUNTOS_SERVICE)
        let jsonData = NSData(contentsOfURL: url!)
        let arrayMovimientoModel = movimientos.getMovimientosModel(jsonData!)
        return arrayMovimientoModel
    }

    //MARK: - GET LOCALIDADES
    func getLocalidades() -> [TOLocalidadModel]{
        
        let url = NSURL(string: CONSTANTES.BASEURLIDLOCALIDAD + CONSTANTES.BASEIDP + CONSTANTES.LOCALIDADES_SERVICE)
        let jsonData = NSData(contentsOfURL: url!)
        let arrayLocalidadesModel = localidades.getLocalidadesModel(jsonData!)
        return arrayLocalidadesModel
    }
    
    //MARK: - GET ACTIVIDADES
    func getActividades() -> [TOActividadModel]{
        
        let url = NSURL(string: CONSTANTES.BASEURLIDLOCALIDAD + CONSTANTES.BASEIDP + CONSTANTES.ACTIVIDADES_SERVICE)
        let jsonData = NSData(contentsOfURL: url!)
        let arrayActividadesModel = actividades.getActividadesModel(jsonData!)
        return arrayActividadesModel
    }
    
    //MARK: - GET BANNERS
    func getBanners(idlocalidad : String) -> [TOBannersModel]{
        
        let idlocalidad = CONSTANTES.PFUSERIDLOCALIDAD
        let url = NSURL(string: CONSTANTES.BASEURLIDLOCALIDAD + idlocalidad + CONSTANTES.BASEIDP + CONSTANTES.BANNERS_SERVICE)
        let jsonData = NSData(contentsOfURL: url!)
        let arrayBannersModel = banners.getBannersModel(jsonData!)
        return arrayBannersModel
    }
    
    //MARK: - GET SAVEUSER
    func getSaveUser(parseID : String!) -> String{
        
        let url = NSURL(string: CONSTANTES.BASEURLIDPARSE + parseID + CONSTANTES.BASEIDP + CONSTANTES.NUEVOCLIENTE_SERVICE)
        let data = NSData(contentsOfURL: url!)
        let id = NSString(data: data!, encoding: NSUTF8StringEncoding)!
        return String(id)
  
    }
}
