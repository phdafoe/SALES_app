//
//  MovimientosTableViewCell.swift
//  TusOfertas
//
//  Created by User on 16/4/16.
//  Copyright © 2016 iCologic. All rights reserved.
//

import UIKit

class MovimientosTableViewCell: UITableViewCell {
    
    //MARK: - IBOUTLET
    
    @IBOutlet weak var myNombreLBL: UILabel!
    @IBOutlet weak var myPuntosConseguidos: UILabel!
    @IBOutlet weak var myPuntosCanjeados: UILabel!
    @IBOutlet weak var myFechaLBL: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
