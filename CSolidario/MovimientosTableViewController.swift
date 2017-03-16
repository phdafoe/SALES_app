//
//  MovimientosTableViewController.swift
//  TusOfertas
//
//  Created by User on 16/4/16.
//  Copyright © 2016 iCologic. All rights reserved.
//

import UIKit
import Parse

class MovimientosTableViewController: UITableViewController {
    
    //MARK: - VARIABLES LOCALES GLOBALES
    var arrayMovimientos = [TOMovimientoModel]()
    var sumaMovimientos : Float = 0
    var label: UILabel = UILabel()
    
    
    @IBOutlet weak var myLabelTotalMovimientos: UILabel!
    
    
    //MARK: - IBACTION
    @IBAction func OKACTION(_ sender: AnyObject) {

        dismiss(animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrayMovimientos = TOAPIDatabaseManager.sharedInstance.getMovimientos((PFUser.current()?["databaseID"])! as! String)
        myLabelTotalMovimientos.text = "Total puntos: \(setupTotalPuntos())"
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayMovimientos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MovimientosTableViewCell
        
        let movimientosModel : TOMovimientoModel = arrayMovimientos[indexPath.row]
        
        cell.myNombreLBL.text = movimientosModel.nombre
        cell.myPuntosCanjeados.text = movimientosModel.puntosCanjeados
        cell.myPuntosConseguidos.text = movimientosModel.puntosConseguidos
        cell.myFechaLBL.text = movimientosModel.fecha
 
        return cell
    }
    
    //MARK: - UTILS
    func setupTotalPuntos() -> String!{
        for i in 0 ..< arrayMovimientos.count{
            let movimientoModel : TOMovimientoModel = arrayMovimientos[i]
            sumaMovimientos = sumaMovimientos + Float(movimientoModel.puntosConseguidos!)! - Float(movimientoModel.puntosCanjeados!)!
         }
        return String(sumaMovimientos)
    }
}







