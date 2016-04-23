//
//  OfertasTableViewCell.swift
//  SidebarMenu
//
//  Created by Simon Ng on 2/2/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import UIKit

class ConcursosTableViewCell: UITableViewCell {
    
    @IBOutlet weak var myImagenConcurso:UIImageView!
    @IBOutlet weak var myFechaFin:UILabel!
    @IBOutlet weak var myMasInformacion:UILabel!
    @IBOutlet weak var myImporte:UILabel!
    @IBOutlet weak var myLogoImageIV: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        myLogoImageIV.layer.cornerRadius = myLogoImageIV.frame.width / 16
        myLogoImageIV.layer.borderColor = UIColor(red: 0.71, green: 0.75, blue: 0.20, alpha: 1.0).CGColor
        myLogoImageIV.layer.borderWidth = 1.5
        myLogoImageIV.layer.shadowColor = UIColor.blackColor().CGColor
        myLogoImageIV.layer.shadowOffset = CGSizeMake(0, 15)
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
