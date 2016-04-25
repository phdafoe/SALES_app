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
    
    @IBAction func myLoginUserACTION(sender: AnyObject) {
        if myUserNameTF.text == "" || myPasswordTF.text == "" {
            
            showAlertViewController("Rellene todos los datos", messageData: "El usuario y el password son obligatorios")
        } else {
            
            myActivityIndicator.hidden = false
            myActivityIndicator.startAnimating()
            
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            
            PFUser.logInWithUsernameInBackground(self.myUserNameTF.text!, password: self.myPasswordTF.text!) {
                (user: PFUser?, loginError: NSError?) -> Void in
                
                self.myActivityIndicator.hidden = true
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                
                if user != nil {
                    print("El usuario ha podido acceder")
                    self.performSegueWithIdentifier("jumpLoginToViewContoller", sender: self)
                    
                    self.myUserNameTF.text = ""
                    self.myPasswordTF.text = ""
                } else {
                    if let errorString = loginError!.userInfo["error"] as? NSString{
                        
                        self.showAlertViewController("Error al acceder", messageData: errorString as String)
                        
                    } else {
                        
                        self.showAlertViewController("Error al acceder", messageData: "Por favor reintenta el acceso")
                        
                    }
                    
                }
                
            }
        }
        
    }
    
    func showAlertViewController(titleData: String, messageData: String){
        
        
        let alertController = UIAlertController(title: titleData, message: messageData, preferredStyle: .Alert)
        
        alertController.addAction((UIAlertAction(title: "OK", style: .Cancel, handler: nil)))
        
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myActivityIndicator.hidden = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if (PFUser.currentUser()?.username != nil) {
            self.performSegueWithIdentifier("jumpLoginToViewContoller", sender: self)
            
        }
    }

}
