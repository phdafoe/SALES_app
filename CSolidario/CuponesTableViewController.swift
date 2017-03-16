//
//  OfertasTableViewController.swift
//  SidebarMenu
//
//  Created by Simon Ng on 2/2/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import UIKit
import Parse


class CuponesTableViewController: UITableViewController {
    
    //MARK: - VARIABLES LOCALES (TIPO OFERTAS)
    var arrayCupones = [TOPromocionModel]()
    var refresh = UIRefreshControl()
    let CONSTANTES = Constants()
    

    @IBOutlet var menuButton:UIBarButtonItem!
    @IBOutlet var extraButton:UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        refresh.backgroundColor = UIColor(red: 0.71, green: 0.75, blue: 0.20, alpha: 1.0)
        refresh.attributedTitle = NSAttributedString(string: "Arrastra para recargar")
        refresh.addTarget(self, action: #selector(CuponesTableViewController.refreshController), for: .valueChanged)
        tableView.addSubview(refresh)

        
        getSingletonApiDataBaseManager()

        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        }
        
    }
    
    func getSingletonApiDataBaseManager(){
        arrayCupones = TOAPIDatabaseManager.sharedInstance.getPromociones(PFUser.current()!["idLocalidad"] as! String, tipo: CONSTANTES.CUPONES)
    }
    
    
    func refreshController(){
        
        getSingletonApiDataBaseManager()
        tableView.reloadData()
        self.refresh.endRefreshing()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getSingletonApiDataBaseManager()
        tableView.reloadData()
        self.refresh.endRefreshing()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayCupones.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CuponesTableViewCell

        let ofertasModel : TOPromocionModel = arrayCupones[indexPath.row]
        
        cell.myFechaFin.text = ofertasModel.fechaValidez
        cell.myMasInformacion.text = ofertasModel.descripcion
        cell.myImporte.text = ofertasModel.tipo
        
        ImageLoader.sharedLoader.imageForUrl(getImagePath(CONSTANTES.CUPONES, id: ofertasModel.id, name: ofertasModel.imagenURL)) { (image, url) in
            cell.myImagenCupon.image = image
        }
        
        return cell
    }
    
    
    func getImagePath(_ type: String, id : String!, name : String!) -> String{
        
        return CONSTANTES.BASE_PHOTO_URL + id + "/" + name
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detalleOfertasVC = self.storyboard?.instantiateViewController(withIdentifier: "detalleCupones") as! DetalleCuponesViewController
        
        let ofertasModel : TOPromocionModel = arrayCupones[indexPath.row]

        
        
        let imageData = UIImage(data: try! Data(contentsOf: URL(string: getImagePath(CONSTANTES.CUPONES, id: ofertasModel.id, name: ofertasModel.imagenURL))!))

        detalleOfertasVC.detalleImagenOfertaData = imageData
        detalleOfertasVC.detalleNombreOfertaData = ofertasModel.tipo
        detalleOfertasVC.detalleFechaFinData = ofertasModel.fechaValidez
        detalleOfertasVC.detalleMasInformacionData = ofertasModel.descripcion
        detalleOfertasVC.detalleTipoOferta = ofertasModel.id
        
        
        //ID DE SOCIO OJO
        detalleOfertasVC.qrData = PFUser.current()!["databaseID"] as? String
        detalleOfertasVC.codeBarData = PFUser.current()!["databaseID"] as? String
        
        
        //DETALLE ASOCIADO
        detalleOfertasVC.detalleImagenAsociado = imageData
        detalleOfertasVC.detallenombreAsociado = ofertasModel.asociado?.nombre
        detalleOfertasVC.detalleDescripcionAsociado = ofertasModel.asociado?.descripcion
        detalleOfertasVC.detalleDireccionAsociado = ofertasModel.asociado?.direccion
        detalleOfertasVC.detalleCondicionesEspecialesAsociado = ofertasModel.asociado?.condicionesEspeciales
        detalleOfertasVC.detalleEmailAsociado = ofertasModel.asociado?.email
        detalleOfertasVC.detalleTelefonoFijoAsociado = ofertasModel.asociado?.telefonoFijo
        detalleOfertasVC.detalleTelefonoMovilAsociado = ofertasModel.asociado?.telefonoMovil
        detalleOfertasVC.detalleWebAsociado = ofertasModel.asociado?.web
        
        navigationController?.pushViewController(detalleOfertasVC, animated: true)
        
        print("Seleccionado \(arrayCupones[indexPath.row])")
        
    
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
        
    }

}
