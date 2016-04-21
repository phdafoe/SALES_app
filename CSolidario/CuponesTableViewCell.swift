//
//  OfertasTableViewCell.swift
//  SidebarMenu
//
//  Created by Simon Ng on 2/2/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import UIKit

class CuponesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var myImagenCupon:UIImageView!
    @IBOutlet weak var myFechaFin:UILabel!
    @IBOutlet weak var myMasInformacion:UILabel!
    @IBOutlet weak var myImporte:UILabel!
    @IBOutlet weak var myLogoIV: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        myLogoIV.layer.cornerRadius = myLogoIV.frame.width / 16
        myLogoIV.layer.borderColor = UIColor.whiteColor().CGColor
        myLogoIV.layer.borderWidth = 1.0
        myLogoIV.layer.shadowColor = UIColor.blackColor().CGColor
        myLogoIV.layer.shadowOffset = CGSizeMake(0, 15)

        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
