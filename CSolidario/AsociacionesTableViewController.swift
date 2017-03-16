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
    var refresh = UIRefreshControl()
    let CONSTANTES = Constants()
    var arrayAsociaciones = [TOAsociacionModel]()
    
    
    //MARK: - IBACTION
    @IBAction func closeViewController(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        refresh.backgroundColor = UIColor(red: 0.71, green: 0.75, blue: 0.20, alpha: 1.0)
        refresh.attributedTitle = NSAttributedString(string: "Arrastra para recargar")
        refresh.addTarget(self, action: #selector(AsociacionesTableViewController.refreshController), for: .valueChanged)
        tableView.addSubview(refresh)

        getSingletonApiDataBaseManager()

    }
    
    func getSingletonApiDataBaseManager(){
        arrayAsociaciones = TOAPIDatabaseManager.sharedInstance.getAsociaciones(PFUser.current()!["idLocalidad"] as! String)
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

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayAsociaciones.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AsociacionesTableViewCell
        
        let asociacionModel : TOAsociacionModel = arrayAsociaciones[indexPath.row]
        
        cell.myNombreAsociadoLBL.text = asociacionModel.nombre
        cell.myDireccionLBL.text = asociacionModel.direccion
        cell.myWebLBL.text = asociacionModel.web
  
        ImageLoader.sharedLoader.imageForUrl(getImagePath(CONSTANTES.ASOCIACIONES_IMAGENES, id: asociacionModel.id!, name: asociacionModel.imagenURL!)) { (image, url) in
            cell.myImageAsociacionesIV.image = image
        }
        
        
        return cell
    }
    
    func getImagePath(_ type: String, id : String, name : String) -> String{

            return CONSTANTES.BASE_PHOTO_URL_ASOCIACIONES + type + "/" + "/" + id  + "/" + name
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detalleAsociacionesVC = self.storyboard?.instantiateViewController(withIdentifier: "detalleAsociaciones") as! DetalleAsociacionesViewController

        let asociacionModel : TOAsociacionModel = arrayAsociaciones[indexPath.row]
        
        let imageData = UIImage(data: try! Data(contentsOf: URL(string: getImagePath(CONSTANTES.ASOCIACIONES_IMAGENES, id: asociacionModel.id!, name: asociacionModel.imagenURL!))!))

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
