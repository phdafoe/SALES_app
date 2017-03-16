//
//  TOPromocionModel.swift
//  SidebarMenu
//
//  Created by User on 10/4/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class TOPromocionModel: NSObject {
    
    var tipo : String?
    var imagenURL : String?
    var titulo : String?
    var descripcion : String?
    var asociado : TOAsociadoModel?
    var id : String?
    var fechaValidez : String?

    
    init(aImagenURL : String, aTitulo : String, aDescripcion : String, aAsociado : TOAsociadoModel, aId : String, aFechaValidez : String, aTipo : String) {
        
        self.tipo = aTipo
        self.imagenURL = aImagenURL
        self.titulo = aTitulo
        self.descripcion = aDescripcion
        self.asociado = aAsociado
        self.id = aId
        self.fechaValidez = aFechaValidez
        
        super.init()
        
    }
    
    
    override init() {
        super.init()
    }
    

}
