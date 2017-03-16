//
//  TOAPIDatabaseManager.swift
//  
//
//  Created by User on 15/4/16.
//
//

import UIKit
import Parse

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
    func getPromociones(_ idLocalidad : String, tipo : String) -> [TOPromocionModel]{
        let url = URL(string: CONSTANTES.BASEURLIDLOCALIDAD + idLocalidad + CONSTANTES.BASEIDTIPO + tipo + CONSTANTES.BASEIDP + CONSTANTES.PROMOCIONES_SERVICE)
        print("AQUI - \(url!)")
        let jsonData = try? Data(contentsOf: url!)
        let arrayPromocionModel = promociones.getPromocionesModel(jsonData!)
        return arrayPromocionModel
    }
    
    //MARK: - GET ASOCIACIONES
    func getAsociaciones(_ idlocalidad : String) -> [TOAsociacionModel]{
        let url = URL(string: CONSTANTES.BASEURLIDLOCALIDAD + idlocalidad + CONSTANTES.BASEIDP + CONSTANTES.ASOCIACIONES_SERVICE)
        let jsonData = try? Data(contentsOf: url!)
        let arrayAsociones =  asociaciones.getAsociacionesModel(jsonData!)
        return arrayAsociones
    }

    //MARK: - GET MOVIMIENTOS
    func  getMovimientos(_ idCliente : String) -> [TOMovimientoModel]{
        let url = URL(string: CONSTANTES.BASEURLIDCLIENTE + idCliente + CONSTANTES.BASEIDP + CONSTANTES.PUNTOS_SERVICE)
        let jsonData = try? Data(contentsOf: url!)
        let arrayMovimientoModel = movimientos.getMovimientosModel(jsonData!)
        return arrayMovimientoModel
    }

    //MARK: - GET LOCALIDADES
    func getLocalidades() -> [TOLocalidadModel]{
        let url = URL(string: CONSTANTES.BASEURLIDLOCALIDAD + CONSTANTES.BASEIDP + CONSTANTES.LOCALIDADES_SERVICE)
        let jsonData = try? Data(contentsOf: url!)
        let arrayLocalidadesModel = localidades.getLocalidadesModel(jsonData!)
        return arrayLocalidadesModel
    }
    
    //MARK: - GET ACTIVIDADES
    func getActividades() -> [TOActividadModel]{
        let url = URL(string: CONSTANTES.BASEURLIDLOCALIDAD + CONSTANTES.BASEIDP + CONSTANTES.ACTIVIDADES_SERVICE)
        let jsonData = try? Data(contentsOf: url!)
        let arrayActividadesModel = actividades.getActividadesModel(jsonData!)
        return arrayActividadesModel
    }
    
    //MARK: - GET BANNERS
    func getBanners(_ idlocalidad : String) -> [TOBannersModel]{
        let idlocalidad = PFUser.current()!["idLocalidad"] as! String
        let url = URL(string: CONSTANTES.BASEURLIDLOCALIDAD + idlocalidad + CONSTANTES.BASEIDP + CONSTANTES.BANNERS_SERVICE)
        let jsonData = try? Data(contentsOf: url!)
        let arrayBannersModel = banners.getBannersModel(jsonData!)
        return arrayBannersModel
    }
    
    //MARK: - GET SAVEUSER
    func getSaveUser(_ parseID : String!) -> String{
        let url = URL(string: CONSTANTES.BASEURLIDPARSE + parseID + CONSTANTES.BASEIDP + CONSTANTES.NUEVOCLIENTE_SERVICE)
        let data = try? Data(contentsOf: url!)
        let id = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!
        return String(id)
  
    }
}
