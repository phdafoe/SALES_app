//
//  TerminosYCondicionesViewController.swift
//  SidebarMenu
//
//  Created by User on 9/4/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class TerminosYCondicionesViewController: UIViewController {
    
    //MARK: - IBACTION
    
    
    @IBAction func okButtonACTION(sender: AnyObject) {
        
        let alertVC = UIAlertController(title: "GENIAL!", message: "Muchas gracias por aceptar las Terminos y condiciones", preferredStyle: .Alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        presentViewController(alertVC, animated: true, completion: nil)
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
