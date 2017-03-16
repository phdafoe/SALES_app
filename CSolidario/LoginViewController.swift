//
//  LoginViewController.swift
//  CSolidario
//
//  Created by User on 25/4/16.
//  Copyright © 2016 iCologic. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var myUserNameTF: UITextField!
    @IBOutlet weak var myPasswordTF: UITextField!
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    
    @IBAction func myLoginUserACTION(_ sender: AnyObject) {
        if myUserNameTF.text == "" || myPasswordTF.text == "" {
            
            showAlertViewController("Rellene todos los datos", messageData: "El usuario y el password son obligatorios")
        } else {
            
            myActivityIndicator.isHidden = false
            myActivityIndicator.startAnimating()
            
            UIApplication.shared.beginIgnoringInteractionEvents()
            
            
            PFUser.logInWithUsername(inBackground: self.myUserNameTF.text!, password: self.myPasswordTF.text!) {
                (user, loginError) -> Void in
                
                self.myActivityIndicator.isHidden = true
                UIApplication.shared.endIgnoringInteractionEvents()
                
                if user != nil {
                    print("El usuario ha podido acceder")
                    self.performSegue(withIdentifier: "jumpLoginToViewContoller", sender: self)
                    
                    self.myUserNameTF.text = ""
                    self.myPasswordTF.text = ""
                } else {
                    /*if let errorString = loginError!.userInfo["error"] as? NSString{
                        
                        self.showAlertViewController("Error al acceder", messageData: errorString as String)
                        
                    } else {
                        
                        self.showAlertViewController("Error al acceder", messageData: "Por favor reintenta el acceso")
                        
                    }*/
                    self.showAlertViewController("Error al acceder", messageData: "Por favor reintenta el acceso")
                    
                }
                
            }
        }
        
    }
    
    func showAlertViewController(_ titleData: String, messageData: String){
        
        
        let alertController = UIAlertController(title: titleData, message: messageData, preferredStyle: .alert)
        
        alertController.addAction((UIAlertAction(title: "OK", style: .cancel, handler: nil)))
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myActivityIndicator.isHidden = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (PFUser.current()?.username != nil) {
            self.performSegue(withIdentifier: "jumpLoginToViewContoller", sender: self)
            
        }
    }

}
