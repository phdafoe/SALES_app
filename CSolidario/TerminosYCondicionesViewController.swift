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
    
    
    @IBAction func okButtonACTION(_ sender: AnyObject) {
        
        let alertVC = UIAlertController(title: "GENIAL!", message: "Muchas gracias por aceptar las Terminos y condiciones", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            
            self.dismiss(animated: true, completion: nil)
        }))
        
        present(alertVC, animated: true, completion: nil)
        
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
