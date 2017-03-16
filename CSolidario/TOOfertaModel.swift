//
//  TOOfertaModel.swift
//  SidebarMenu
//
//  Created by User on 11/4/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class TOOfertaModel: NSObject {
    
    var id : Int?
    var offerTitle : String?
    var descriptionData : String?
    var location : String?
    var picture : UIImage?
    var sector : String?
    var activity : String?
    var validity : Date?
    
    init(aId : Int, aOfferTitle : String, aDescriptionData : String, aLocation : String, aPicture : UIImage, aSector : String, aActivity : String, aValidity : Date) {
        self.id = aId
        self.offerTitle = aOfferTitle
        self.descriptionData = aDescriptionData
        self.location = aLocation
        self.picture = aPicture
        self.sector = aSector
        self.activity = aActivity
        self.validity = aValidity
        super.init()
    }
    

}
