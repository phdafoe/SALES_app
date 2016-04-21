//
//  CBConcursosViewController.swift
//  TusOfertas
//
//  Created by User on 19/4/16.
//  Copyright © 2016 iCologic. All rights reserved.
//

import UIKit

class CBConcursosViewController: UIViewController {

    //MARK: - VARIABLES
    var codeBarData : String?
    
    
    //MARK: - IBOUTLET
    
    @IBOutlet weak var myCuponNameLBL: UILabel!
    @IBOutlet weak var myImageViewIV: UIImageView!
    
    
    
    //MARK: - IBACTION
    @IBAction func OKACTION(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func generateBarcodeACTION(sender: AnyObject) {
        
        
        myImageViewIV.image = fromString(codeBarData!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myCuponNameLBL.text = codeBarData
        myCuponNameLBL.textColor = UIColor.whiteColor()
        self.title = "Escaner Código de Barras"
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func fromString(string : String) -> UIImage? {
        
        let data = string.dataUsingEncoding(NSASCIIStringEncoding)
        let filter = CIFilter(name: "CICode128BarcodeGenerator")
        filter!.setValue(data, forKey: "inputMessage")
        return UIImage(CIImage: filter!.outputImage!)
        
    }

}
