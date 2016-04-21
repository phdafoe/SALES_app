//
//  RegistrerViewController.swift
//  SidebarMenu
//
//  Created by User on 9/4/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit
import Parse


class RegistrerViewController: UIViewController {
    
    //MARK: - VARIABLES LOCALES GLOBALES
    var photoSelected = false
    var movimientos = [TOMovimientoModel]()
    
    var parseId : String?
    var id : String?
    var totalPuntos : Int?
    
    
    var locationData = ["Alcalá de Henares","Alcobendas","Alcorcón","Coslada", "Móstoles", "San Sebastián de los Reyes", "Torrejón de Ardoz"]
    var AssociationData = ["Reparto entre todas","ADAP", "APARKAM", "Mis Amigos Especiales", "Ninguna"]

    
    //MARK: - IBOUTLET
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myLocationCity: UITextField!
    @IBOutlet weak var myAssociationSend: UITextField!
    @IBOutlet weak var myUsernameTF: UITextField!
    @IBOutlet weak var myPasswordTF: UITextField!
    @IBOutlet weak var myNameTF: UITextField!
    @IBOutlet weak var myLastNameTF: UITextField!
    @IBOutlet weak var myEmailTF: UITextField!
    @IBOutlet weak var myPhoneNumberTF: UITextField!
    

    
    //MARK: - IBACTION
    @IBAction func sendInformationToParse(sender: AnyObject) {
        
        var errorInitial = ""
        
        if myUsernameTF.text == "" || myPasswordTF.text == "" || myNameTF.text == "" || myLastNameTF.text == "" || myEmailTF.text == "" || myLocationCity.text == "" || myAssociationSend.text == "" || myImageView.image == nil{
            
            errorInitial = "Por favor rellena todos los campos obligatorios, muchas gracias"
            
        }else{
            
            //Fase 2 iCoSelf -> Aqui traemos desde parse del registro del usuario
            let user = PFUser()
            user["idLocalidad"] = myLocationCity.text
            user["asociacion"] = myAssociationSend.text
            user["nombre"] = myNameTF.text
            user["apellidos"] = myLastNameTF.text
            user["telefonoMovil"] = myPhoneNumberTF.text
            user.username = myUsernameTF.text
            user.password = myPasswordTF.text
            user.email = myEmailTF.text
            
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            user.signUpInBackgroundWithBlock {
                
                //Cambiemos el nombre de la variable error a signUpError para no tener problemas con nuetro error de arriba
                (succeeded: Bool, signUpError: NSError?) -> Void in
                
                //->  ActivityIndicator
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                
                let errorData = signUpError
                var errorDataPost = ""
                
                if !self.photoSelected{
                    errorDataPost = "Por favor elige una foto de la galeria o toma una fotografia"
                }
                
                if errorDataPost != ""{
                    self.displayAlertVC("Error en los datos", messageData: errorDataPost)
                }
                
                if errorData != nil {
                    
                    if let errorString = errorData!.userInfo["error"] as? NSString{
                        self.displayAlertVC("Error al registrar", messageData: errorString as String)
                        
                    }else{
                        self.displayAlertVC("Error al registrar el Usuario", messageData: "Por favor Reintenta el Registro")
                    }
                    
                } else {
                    
                    self.signUpAndPostImage()
                    self.geoPointParse()
                    
                }
            }
        }
        
        if errorInitial != ""{
            displayAlertVC("Error al registrar", messageData: errorInitial)
        }
        
        
    }
    
    @IBAction func selectPhotoOnDeviceACTION(sender: AnyObject) {
        pickPhoto()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        let pickerViewLocationData = UIPickerView()
        pickerViewLocationData.delegate = self
        pickerViewLocationData.tag = 1
        myLocationCity.inputView = pickerViewLocationData
        myLocationCity.text = locationData[0]
        
        
        let pickerViewAssociationData = UIPickerView()
        pickerViewAssociationData.delegate = self
        pickerViewAssociationData.tag = 2
        myAssociationSend.inputView = pickerViewAssociationData
        myAssociationSend.text = AssociationData[0]

        myImageView.layer.cornerRadius = myImageView.frame.size.width / 2
        myImageView.clipsToBounds = true

        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        //Comprobamos que si algun usuario ha accedido
        if PFUser.currentUser() != nil{
            //OJO EL TIPO DE SEGUE TIENE QUE SER MODAL Y NO PUSH GENERA UN PROBLEMA DE SOPORTE
            self.performSegueWithIdentifier("jumpToViewContoller", sender: self)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //MARK: - UTILS
    
    func displayAlertVC(titleData:String, messageData:String){
        
        let alertVC = UIAlertController (title: titleData, message: messageData, preferredStyle: .Alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(alertVC, animated: true, completion: nil)
    }
    
    func signUpAndPostImage(){

        let postImage = PFObject(className: "ImageProfile")
        
        let imageData = UIImageJPEGRepresentation(self.myImageView.image!, 0.6)
        
        let imageFile = PFFile(name: "image.jpg", data: imageData!)
        
        postImage["imagenURL"] = imageFile
        
        postImage["username"] = PFUser.currentUser()?.username
        
        postImage.saveInBackgroundWithBlock({ (success, error) -> Void in
            if success{
                self.displayAlertVC("Publicacion completada", messageData: "Tu foto ha sido publicada")
            }else{
                self.displayAlertVC("No se pudo publicar", messageData: "no se pudo subir los datos")
            }
            self.photoSelected = false
            self.myImageView.image = UIImage(named: "placeholderPerson.png")
        })
        
        //OJO EL TIPO DE SEGUE TIENE QUE SER MODAL Y NO PUSH GENERA UN PROBLEMA DE SOPORTE
        self.performSegueWithIdentifier("jumpToViewContoller", sender: self)
        
        print("El Usuario ha logrado Registrarse")
        
        self.myLocationCity.text = ""
        self.myAssociationSend.text = ""
        self.myUsernameTF.text = ""
        self.myPasswordTF.text = ""
        self.myNameTF.text = ""
        self.myLastNameTF.text = ""
        self.myEmailTF.text = ""
        self.myPhoneNumberTF.text = ""
        
    }
    
    func geoPointParse(){
        
        //GEOPOINT
        PFGeoPoint.geoPointForCurrentLocationInBackground {
            (geoPoint: PFGeoPoint?, error: NSError?) -> Void in
            
            if error == nil {
                
                let user = PFUser.currentUser()!
                user["lastLocation"] = geoPoint
                user.saveInBackground()
                
            }else{
                print(error)
            }
            
        }
    }

    //MARK: - DOWNKEYBOARD
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

}

//MARK: - UIImagePickerPhotoDelegate
extension RegistrerViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func pickPhoto(){
        if UIImagePickerController.isSourceTypeAvailable(.Camera){
            showPhotoMenu()
        }else{
            choosePhotoFromLIbrary()
        }
    }
    
    func showPhotoMenu(){
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        let cancelAccion = UIAlertAction(title: "Cancelar", style: .Cancel, handler: nil)
        let takePhotoAction = UIAlertAction(title: "Tomar la foto", style: .Default, handler: {
            Void in self.takePhotoWithCamera()
        })
        let chooseFromLibraryAction = UIAlertAction(title: "Escoger desde la Libreria", style: .Default, handler: {
            Void in self.choosePhotoFromLIbrary()
        })
        alertController.addAction(cancelAccion)
        alertController.addAction(takePhotoAction)
        alertController.addAction(chooseFromLibraryAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    func takePhotoWithCamera(){
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .Camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    func choosePhotoFromLIbrary(){
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .PhotoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        myImageView.image = image
        dismissViewControllerAnimated(true, completion: nil)
        self.photoSelected = true
    }
    
}

//MARK: - PICKERVIEW DELEGATE
extension RegistrerViewController : UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        if pickerView.tag == 1{
            return locationData.count
        }else{
            return AssociationData.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 1{
            return locationData[row]
        }else{
            return AssociationData[row]
        }
    }
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 1{
        self.myLocationCity.text = self.locationData[row]
        }else{
        self.myAssociationSend.text = self.AssociationData[row]
        }
        
    }  
}





