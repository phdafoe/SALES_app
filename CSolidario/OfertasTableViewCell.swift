//
//  OfertasTableViewCell.swift
//  SidebarMenu
//
//  Created by Simon Ng on 2/2/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import UIKit

class OfertasTableViewCell: UITableViewCell {
    
    @IBOutlet weak var myImagenCupon:UIImageView!
    @IBOutlet weak var myFechaFin:UILabel!
    @IBOutlet weak var myMasInformacion:UILabel!
    @IBOutlet weak var myImporte:UILabel!
    @IBOutlet weak var myImageLogoIV: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        myImageLogoIV.layer.cornerRadius = myImageLogoIV.frame.width / 16
        myImageLogoIV.layer.borderColor = UIColor.whiteColor().CGColor
        myImageLogoIV.layer.borderWidth = 1.0
        myImageLogoIV.layer.shadowColor = UIColor.blackColor().CGColor
        myImageLogoIV.layer.shadowOffset = CGSizeMake(0, 15)

        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}