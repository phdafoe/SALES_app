//
//  AsociacionesTableViewCell.swift
//  SidebarMenu
//
//  Created by User on 12/4/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class AsociacionesTableViewCell: UITableViewCell {
    
    //MARK: - IBOUTLET
    
    
    @IBOutlet weak var myImageAsociacionesIV: UIImageView!
    @IBOutlet weak var myNombreAsociadoLBL: UILabel!
    @IBOutlet weak var myDireccionLBL: UILabel!
    @IBOutlet weak var myWebLBL: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()

        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
