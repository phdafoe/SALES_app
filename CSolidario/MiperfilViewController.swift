//
//  MiperfilViewController.swift
//  CSolidario
//
//  Created by User on 23/4/16.
//  Copyright © 2016 iCologic. All rights reserved.
//

import UIKit
import Parse



class MiperfilViewController: UIViewController {
    
    //MARK: - VARIABLES LOCALES GLOBALES
    let CONSTANTES = Constants()
    var photoSelected = false
    var idLocalidadSeleccionada : String = "0"
    var idAsociacionSeleccionada : String = ""
    
    var locationData = [TOLocalidadModel]()
    var AssociationData = [TOAsociacionModel]()
    
    
    
    
    //MARK: - IBOUTLET
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myLocationCity: UITextField!
    @IBOutlet weak var myAssociationSend: UITextField!
    @IBOutlet weak var myNameTF: UITextField!
    @IBOutlet weak var myLastNameTF: UITextField!
    @IBOutlet weak var myEmailTF: UITextField!
    @IBOutlet weak var myPhoneNumberTF: UITextField!
    
     //MARK: - IBACTION
    @IBAction func selectPhotoOnDeviceACTION(sender: AnyObject) {
        pickPhoto()
    }
    

    @IBAction func okACTION(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)   
        
    }
    
    
    @IBAction func actualizarDatosPerfil(sender: AnyObject) {
        
        actualizarDatos()
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationData = TOAPIDatabaseManager.sharedInstance.getLocalidades()
        idLocalidadSeleccionada = self.locationData[0].id!
        
        let pickerViewLocationData = UIPickerView()
        pickerViewLocationData.delegate = self
        pickerViewLocationData.tag = 1
        myLocationCity.inputView = pickerViewLocationData
        myLocationCity.text = locationData[0].nombre
        
        AssociationData = TOAPIDatabaseManager.sharedInstance.getAsociaciones(idLocalidadSeleccionada)
        
        let pickerViewAssociationData = UIPickerView()
        pickerViewAssociationData.delegate = self
        pickerViewAssociationData.tag = 2
        myAssociationSend.inputView = pickerViewAssociationData
        myAssociationSend.text = AssociationData[0].nombre
        
        myImageView.layer.cornerRadius = myImageView.frame.size.width / 2
        myImageView.clipsToBounds = true

        findDataFromParse()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - UTILS
    
    func findDataFromParse(){
        
        let query = PFUser.query()!
        query.whereKey(CONSTANTES.USERNAMEPARSE, equalTo: (PFUser.currentUser()?.username)!)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                if let objects = objects {
                    
                    for objectData in objects {
                        
                        
                        let query = PFQuery(className:self.CONSTANTES.IDNOMBRETABLAIMAGEN)
                        query.whereKey(self.CONSTANTES.USERNAMEPARSE, equalTo:(PFUser.currentUser()?.username)!)
                        query.findObjectsInBackgroundWithBlock {
                            (objects: [PFObject]?, error: NSError?) -> Void in
                            if error == nil {
                                if let objects = objects {
                                    for objectData in objects {
                                        
                                        let userImageFile = objectData[self.CONSTANTES.IDIMAGENURL] as! PFFile
                                        userImageFile.getDataInBackgroundWithBlock {
                                            (imageData: NSData?, error: NSError?) -> Void in
                                            if error == nil {
                                                if let imageData = imageData {
                                                    let image = UIImage(data:imageData)
                                                    self.myImageView.image = image
                                                }
                                            }
                                        }
                                    }
                                }
                                
                            } else {
                                // Log details of the failure
                                print("Error: \(error!) \(error!.userInfo)")
                            }
                        }
                        
                        //print("El usurio es \(objectData)")
                        self.myNameTF.text = objectData[self.CONSTANTES.IDNOMBRE] as? String
                        self.myLastNameTF.text = objectData[self.CONSTANTES.IDAPELLIDOS] as? String
                        self.myPhoneNumberTF.text = objectData[self.CONSTANTES.IDTELEFONOMOVIL] as? String
                        self.myEmailTF.text = objectData[self.CONSTANTES.IDMAIL] as? String
                        
                    }
                }
            } else {
                // Log details of the failure
                print("Error consultando usuarios \(error?.description)")
            }
        }
    }
    
    func actualizarDatos(){
        
        let userData = PFUser.currentUser()!
        userData[self.CONSTANTES.IDLOCALIDAD] = idLocalidadSeleccionada
        userData[self.CONSTANTES.IDASOCIACION] = idAsociacionSeleccionada
        userData[self.CONSTANTES.IDNOMBRE] = myNameTF.text
        userData[self.CONSTANTES.IDAPELLIDOS] = myLastNameTF.text
        userData[self.CONSTANTES.IDTELEFONOMOVIL] = myPhoneNumberTF.text
        userData.email = myEmailTF.text
        
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
        userData.saveInBackgroundWithBlock { (success, error) in
            
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
            
            if success{
                print("El Usuario ha sido modificado correctamente")
                self.updatePhoto()
            }else{
                print(self.CONSTANTES.ERRORREGISTRO)
            }
        }
    }
    
    
    func updatePhoto(){
        
        let postImage = PFObject(className: "ImageProfile")
        let imageData = UIImageJPEGRepresentation(self.myImageView.image!, 0.6)
        let imageFile = PFFile(name: "image.jpg", data: imageData!)
        postImage[self.CONSTANTES.IDIMAGENURL] = imageFile
        postImage[self.CONSTANTES.USERNAMEPARSE] = PFUser.currentUser()?.username
        postImage.saveInBackgroundWithBlock({ (success, error) -> Void in
            if success{
                self.displayAlertVC("Publicacion completada", messageData: "Tu foto ha sido publicada")
            }else{
                self.displayAlertVC("No se pudo publicar", messageData: "no se pudo subir los datos")
            }
            self.photoSelected = false
            self.myImageView.image = UIImage(named: "placeholderPerson.png")
        })
    }
    
    
    func displayAlertVC(titleData:String, messageData:String){
        
        let alertVC = UIAlertController (title: titleData, message: messageData, preferredStyle: .Alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(alertVC, animated: true, completion: nil)
    }
    
    
    //MARK: - DOWNKEYBOARD
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    


}



//MARK: - UIImagePickerPhotoDelegate
extension MiperfilViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
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
extension MiperfilViewController : UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    
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
            return locationData[row].nombre
        }else{
            return AssociationData[row].nombre
        }
    }
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 1{
            self.myLocationCity.text = self.locationData[row].nombre!
            self.idLocalidadSeleccionada = self.locationData[row].id!
            
        }else{
            self.myAssociationSend.text = self.AssociationData[row].nombre!
            self.idAsociacionSeleccionada = self.AssociationData[row].id!
        }
        
    }  
}

