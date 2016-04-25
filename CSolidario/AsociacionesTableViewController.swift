//
//  AsociacionesTableViewController.swift
//  SidebarMenu
//
//  Created by User on 12/4/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit
import Parse

class AsociacionesTableViewController: UITableViewController {
    
 
    //MARK: - VARIABLES LOCALES GLOBALES
    var refresh : UIRefreshControl?
    let CONSTANTES = Constants()

    
    var arrayAsociaciones = [TOAsociacionModel]()
    
    
    //MARK: - IBACTION
    @IBAction func closeViewController(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        refresh = UIRefreshControl()
        refresh?.attributedTitle = NSAttributedString(string: "Arrastra para recargar")
        refresh?.addTarget(self, action: #selector(AsociacionesTableViewController.refreshControll), forControlEvents: .ValueChanged)
        tableView.addSubview(refresh!)
        
        getSingletonApiDataBaseManager()

    }
    
    func getSingletonApiDataBaseManager(){
        
        arrayAsociaciones = TOAPIDatabaseManager.sharedInstance.getAsociaciones(PFUser.currentUser()!["idLocalidad"] as! String)
        
    }
    
    
    func refreshControll(){
        
        getSingletonApiDataBaseManager()
        tableView.reloadData()
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
        
        return arrayAsociaciones.count
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 190
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! AsociacionesTableViewCell

        let asociacionModel : TOAsociacionModel = arrayAsociaciones[indexPath.row]
        
        
        cell.myNombreAsociadoLBL.text = asociacionModel.nombre
        cell.myDireccionLBL.text = asociacionModel.direccion
        cell.myWebLBL.text = asociacionModel.web
  
        ImageLoader.sharedLoader.imageForUrl(getImagePath(CONSTANTES.ASOCIACIONES_IMAGENES, id: asociacionModel.id!, name: asociacionModel.imagenURL!)) { (image, url) in
            cell.myImageAsociacionesIV.image = image
        }
        
        
        return cell
    }
    
    func getImagePath(type: String, id : String, name : String) -> String{

            return CONSTANTES.BASE_PHOTO_URL_ASOCIACIONES + type + "/" + "/" + id  + "/" + name
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let detalleAsociacionesVC = self.storyboard?.instantiateViewControllerWithIdentifier("detalleAsociaciones") as! DetalleAsociacionesViewController

        let asociacionModel : TOAsociacionModel = arrayAsociaciones[indexPath.row]
        
        
        
        let imageData = UIImage(data: NSData(contentsOfURL: NSURL(string: getImagePath(CONSTANTES.ASOCIACIONES_IMAGENES, id: asociacionModel.id!, name: asociacionModel.imagenURL!))!)!)
        
        
        
        detalleAsociacionesVC.detalleImageAsociacionAData = imageData
        detalleAsociacionesVC.detalleDescripcionData = asociacionModel.descripcion
        detalleAsociacionesVC.detalleTelefonoFijoData = asociacionModel.telefonoFijo
        detalleAsociacionesVC.detalleTelefonoMovilData = asociacionModel.telefonoMovil
        detalleAsociacionesVC.detallePersonaContactoData = asociacionModel.personaContacto
        detalleAsociacionesVC.detalleWebData = asociacionModel.web
        detalleAsociacionesVC.detalleDireccionData = asociacionModel.direccion
        
        navigationController?.pushViewController(detalleAsociacionesVC, animated: true)
        
        print("Seleccionado \(arrayAsociaciones[indexPath.row])")   
        
    }

}
