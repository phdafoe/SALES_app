//
//  OfertasTableViewController.swift
//  SidebarMenu
//
//  Created by Simon Ng on 2/2/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import UIKit
import Parse


class OfertasTableViewController: UITableViewController {
    
     //MARK: - VARIABLES LOCALES
    var arrayOferta = [TOPromocionModel]()
    var refresh : UIRefreshControl?
    let CONSTANTES = Constants()
    
    
    
    @IBOutlet var menuButton:UIBarButtonItem!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresh = UIRefreshControl()
        refresh?.attributedTitle = NSAttributedString(string: "Arrastra para recargar")
        refresh?.addTarget(self, action: #selector(AsociacionesTableViewController.refreshControll), forControlEvents: .ValueChanged)
        tableView.addSubview(refresh!)
        
        getSingletonApiDataBaseManager()

        if revealViewController() != nil {
            //revealViewController().rearViewRevealWidth = 200
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))

            //revealViewController().rightViewRevealWidth = 150
            //extraButton.target = revealViewController()
            //extraButton.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            //view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    
    func getSingletonApiDataBaseManager(){
        
        arrayOferta = TOAPIDatabaseManager.sharedInstance.getPromociones(PFUser.currentUser()!["idLocalidad"] as! String, tipo: CONSTANTES.OFERTAS)
        
    }
    
    
    func refreshControll(){
        
        getSingletonApiDataBaseManager()
        tableView.reloadData()
        self.refresh?.endRefreshing()
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayOferta.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! OfertasTableViewCell

        let ofertasModel : TOPromocionModel = arrayOferta[indexPath.row]
        
        cell.myFechaFin.text = ofertasModel.fechaValidez
        cell.myMasInformacion.text = ofertasModel.descripcion
        cell.myImporte.text = ofertasModel.tipo
        
        print("id:" + ofertasModel.id! + "imagen" + ofertasModel.imagenURL!)
        
        
        ImageLoader.sharedLoader.imageForUrl(getImagePath(CONSTANTES.OFERTAS, id: ofertasModel.id, name: ofertasModel.imagenURL)) { (image, url) in
            cell.myImagenCupon.image = image
        }
        
        return cell
    }
    

    func getImagePath(type: String, id : String!, name : String!) -> String{
        
        return CONSTANTES.BASE_PHOTO_URL + id + "/" + name
        
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let detalleOfertasVC = self.storyboard?.instantiateViewControllerWithIdentifier("detalleOfertas") as! DetalleOfertasViewController
        
        let ofertasModel : TOPromocionModel = arrayOferta[indexPath.row]
        
        let imageData = UIImage(data: NSData(contentsOfURL: NSURL(string: getImagePath(CONSTANTES.OFERTAS, id: ofertasModel.id, name: ofertasModel.imagenURL))!)!)

        detalleOfertasVC.detalleImagenOfertaData = imageData
        detalleOfertasVC.detalleNombreOfertaData = ofertasModel.titulo
        detalleOfertasVC.detalleFechaFinData = ofertasModel.fechaValidez
        detalleOfertasVC.detalleMasInformacionData = ofertasModel.descripcion
        detalleOfertasVC.detalleTipoOferta = ofertasModel.id
        
        
        //ID DE SOCIO OJO
        detalleOfertasVC.qrData = PFUser.currentUser()!["databaseID"] as? String
        detalleOfertasVC.codeBarData = PFUser.currentUser()!["databaseID"] as? String
        
        
        
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
        
        print("Seleccionado \(arrayOferta[indexPath.row])")  
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 220
    }

}

