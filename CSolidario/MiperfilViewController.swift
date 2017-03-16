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
    @IBAction func selectPhotoOnDeviceACTION(_ sender: AnyObject) {
        pickPhoto()
    }
    

    @IBAction func okACTION(_ sender: AnyObject) {
        
        dismiss(animated: true, completion: nil)   
        
    }
    
    
    @IBAction func actualizarDatosPerfil(_ sender: AnyObject) {
        
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
        //myAssociationSend.text = AssociationData[0].nombre
        
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
        query.whereKey(CONSTANTES.USERNAMEPARSE, equalTo: (PFUser.current()?.username)!)
        query.findObjectsInBackground {
            (objects, error) -> Void in
            
            if error == nil {
                if let objects = objects {
                    for objectData in objects {
                        let query = PFQuery(className:self.CONSTANTES.IDNOMBRETABLAIMAGEN)
                        query.whereKey(self.CONSTANTES.USERNAMEPARSE, equalTo:(PFUser.current()?.username)!)
                        query.findObjectsInBackground {
                            (objects, error) -> Void in
                            if error == nil {
                                if let objects = objects {
                                    for objectData in objects {
                                        
                                        let userImageFile = objectData[self.CONSTANTES.IDIMAGENURL] as! PFFile
                                        userImageFile.getDataInBackground {
                                            (imageData, error) -> Void in
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
                                print("Error: \(error!)")
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
                print("Error consultando usuarios")
            }
        }
    }
    
    func actualizarDatos(){
        
        let userData = PFUser.current()!
        userData[self.CONSTANTES.IDLOCALIDAD] = idLocalidadSeleccionada
        userData[self.CONSTANTES.IDASOCIACION] = idAsociacionSeleccionada
        userData[self.CONSTANTES.IDNOMBRE] = myNameTF.text
        userData[self.CONSTANTES.IDAPELLIDOS] = myLastNameTF.text
        userData[self.CONSTANTES.IDTELEFONOMOVIL] = myPhoneNumberTF.text
        userData.email = myEmailTF.text
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        userData.saveInBackground { (success, error) in
            
            UIApplication.shared.endIgnoringInteractionEvents()
            
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
        postImage[self.CONSTANTES.USERNAMEPARSE] = PFUser.current()?.username
        postImage.saveInBackground(block: { (success, error) -> Void in
            if success{
                self.displayAlertVC("Publicacion completada", messageData: "Tu foto ha sido publicada")
            }else{
                self.displayAlertVC("No se pudo publicar", messageData: "no se pudo subir los datos")
            }
            self.photoSelected = false
            self.myImageView.image = UIImage(named: "placeholderPerson.png")
        })
    }
    
    
    func displayAlertVC(_ titleData:String, messageData:String){
        
        let alertVC = UIAlertController (title: titleData, message: messageData, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    
    //MARK: - DOWNKEYBOARD
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    


}



//MARK: - UIImagePickerPhotoDelegate
extension MiperfilViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func pickPhoto(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            showPhotoMenu()
        }else{
            choosePhotoFromLIbrary()
        }
    }
    
    func showPhotoMenu(){
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAccion = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        let takePhotoAction = UIAlertAction(title: "Tomar la foto", style: .default, handler: {
            Void in self.takePhotoWithCamera()
        })
        let chooseFromLibraryAction = UIAlertAction(title: "Escoger desde la Libreria", style: .default, handler: {
            Void in self.choosePhotoFromLIbrary()
        })
        alertController.addAction(cancelAccion)
        alertController.addAction(takePhotoAction)
        alertController.addAction(chooseFromLibraryAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    func takePhotoWithCamera(){
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func choosePhotoFromLIbrary(){
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        myImageView.image = image
        dismiss(animated: true, completion: nil)
        self.photoSelected = true
    }
    
}

//MARK: - PICKERVIEW DELEGATE
extension MiperfilViewController : UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 1{
            return locationData.count
        }else{
            return AssociationData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 1{
            return locationData[row].nombre
        }else{
            return AssociationData[row].nombre
        }
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 1{
            self.myLocationCity.text = self.locationData[row].nombre!
            self.idLocalidadSeleccionada = self.locationData[row].id!
            
        }else{
            self.myAssociationSend.text = self.AssociationData[row].nombre!
            self.idAsociacionSeleccionada = self.AssociationData[row].id!
        }
        
    }  
}

