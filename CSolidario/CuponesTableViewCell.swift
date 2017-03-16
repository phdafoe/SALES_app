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
        myLogoIV.layer.borderColor = UIColor(red: 0.71, green: 0.75, blue: 0.20, alpha: 1.0).cgColor
        myLogoIV.layer.borderWidth = 1.5
        myLogoIV.layer.shadowColor = UIColor.black.cgColor
        myLogoIV.layer.shadowOffset = CGSize(width: 0, height: 15)

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
