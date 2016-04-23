//
//  OfertasTableViewController.swift
//  SidebarMenu
//
//  Created by Simon Ng on 2/2/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import UIKit
import Parse


class ConcursosTableViewController: UITableViewController {
    
    //MARK: - VARIABLES LOCALES
    let CONCURSO = "concurso"
    let BASE_PHOTO_URL = "http://app.clubsinergias.es/uploads/promociones/"
    var refresh : UIRefreshControl?
    var arrayConcursos = [TOPromocionModel]()
    

    @IBOutlet var menuButton:UIBarButtonItem!
    @IBOutlet var extraButton:UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresh = UIRefreshControl()
        refresh?.attributedTitle = NSAttributedString(string: "Arrastra para recargar")
        refresh?.addTarget(self, action: #selector(AsociacionesTableViewController.refreshControll), forControlEvents: .ValueChanged)
        tableView.addSubview(refresh!)
        
        getSingletonApiDataBaseManager()
        
        

        if revealViewController() != nil {
            //revealViewController().rearViewRevealWidth = 62
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            
            //revealViewController().rightViewRevealWidth = 150
            //extraButton.target = revealViewController()
            //extraButton.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            
            //view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    
    func getSingletonApiDataBaseManager(){
        
        arrayConcursos = TOAPIDatabaseManager.sharedInstance.getPromociones(PFUser.currentUser()!["idLocalidad"] as! String, tipo: CONCURSO)
    }
    
    
    func refreshControll(){
        
        getSingletonApiDataBaseManager()
        self.refresh?.endRefreshing()
        
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
        
        return arrayConcursos.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ConcursosTableViewCell

        
        let ofertasModel : TOPromocionModel = arrayConcursos[indexPath.row]
        
        cell.myFechaFin.text = ofertasModel.fechaValidez
        cell.myMasInformacion.text = ofertasModel.descripcion
        cell.myImporte.text = ofertasModel.tipo
        
        ImageLoader.sharedLoader.imageForUrl(getImagePath(CONCURSO, id: ofertasModel.id, name: ofertasModel.imagenURL)) { (image, url) in
            cell.myImagenConcurso.image = image!
        }
        
        return cell
    }
    
    
    func getImagePath(type: String, id : String!, name : String!) -> String{
        
        return BASE_PHOTO_URL + id + "/" + name
        
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let detalleOfertasVC = self.storyboard?.instantiateViewControllerWithIdentifier("detalleConcursos") as! DetalleConcursosViewController
        
        let ofertasModel : TOPromocionModel = arrayConcursos[indexPath.row]

        
        let imageData = UIImage(data: NSData(contentsOfURL: NSURL(string: getImagePath(CONCURSO, id: ofertasModel.id, name: ofertasModel.imagenURL))!)!)
        
        detalleOfertasVC.detalleImagenOfertaData = imageData
        detalleOfertasVC.detalleNombreOfertaData = ofertasModel.tipo
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
        
        print("Seleccionado \(arrayConcursos[indexPath.row])")  
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 220
    }
}


