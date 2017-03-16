//
//  RegistrerViewController.swift
//  SidebarMenu
//
//  Created by User on 9/4/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit
import Parse


class RegistrerViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - VARIABLES LOCALES GLOBALES
    let CONSTANTES = Constants()
    var photoSelected = false
    var parseId : String?
    var id : String?
    var totalPuntos : Int?
    
    var idLocalidadSeleccionada : String = ""
    var idAsociacionSeleccionada : String = ""
    
    var locationData = [TOLocalidadModel]()
    var AssociationData = [TOAsociacionModel]()
    //var saveNewUser = TOUsuarioModel?()
    

    
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
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!

    
    //MARK: - IBACTION
    @IBAction func sendInformationToParse(_ sender: AnyObject) {
        
        var errorInitial = ""
        
        if myUsernameTF.text == "" || myPasswordTF.text == "" || myNameTF.text == "" || myLastNameTF.text == "" || myEmailTF.text == "" || myLocationCity.text == "" || myImageView.image == nil{
            
            errorInitial = CONSTANTES.ERRORESPACIOSENBLANCO
            
        }else{

            let user = PFUser()
            user[CONSTANTES.IDLOCALIDAD] = idLocalidadSeleccionada
            user[CONSTANTES.IDASOCIACION] = idAsociacionSeleccionada
            user[CONSTANTES.IDNOMBRE] = myNameTF.text
            user[CONSTANTES.IDAPELLIDOS] = myLastNameTF.text
            user[CONSTANTES.IDTELEFONOMOVIL] = myPhoneNumberTF.text
            user.username = myUsernameTF.text
            user.password = myPasswordTF.text
            user.email = myEmailTF.text
            
            myActivityIndicator.isHidden = false
            myActivityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            user.signUpInBackground {
                (succeeded, signUpError) -> Void in
                self.myActivityIndicator.isHidden = true
                self.myActivityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                let errorData = signUpError
                var errorDataPost = ""
                
                if !self.photoSelected{
                    errorDataPost = "Por favor elige una foto de la galeria o toma una fotografia"
                }
                if errorDataPost != ""{
                    self.displayAlertVCErrorRegistro(self.CONSTANTES.ERRORREGISTRO as NSString)
                }
                if errorData != nil {
                    
                    /*if let errorString = errorData!.userInfo["error"] as? NSString{
                        self.displayAlertVCErrorRegistro(errorString)
                    }else{
                        
                    }*/
                    self.displayAlertVCErrorRegistro(self.CONSTANTES.ERRORREGISTRO as NSString)
                    
                } else {
                    self.signUpAndPostImage()
                    self.saveUserID()
                    self.geoPointParse()
                }
            }
        }
        if errorInitial != ""{
            self.displayAlertVCEspaciosEnBlanco(CONSTANTES.ERRORESPACIOSENBLANCO)
        }
        
        
    }
    
    @IBAction func selectPhotoOnDeviceACTION(_ sender: AnyObject) {
        pickPhoto()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myActivityIndicator.isHidden = true
        
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

        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        
        //Comprobamos que si algun usuario ha accedido
        if PFUser.current() != nil{
            //OJO EL TIPO DE SEGUE TIENE QUE SER MODAL Y NO PUSH GENERA UN PROBLEMA DE SOPORTE
            self.performSegue(withIdentifier: "jumpToViewContoller", sender: self)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    //MARK: - DOWNKEYBOARD
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: - MENSAJES DE ERROR
    func displayAlertVC(){
        present(utilsDisplayAlertVCGeneral(), animated: true, completion: nil)
    }
    
    func displayAlertVCErrorRegistro(_ errorString : NSString){
        present(utilsDisplayAlertErrorRegistro(errorString as String), animated: true, completion: nil)
    }
    
    func displayAlertVCExitoso(){
        present(utilsDisplayAlertVCExitoso(), animated: true, completion: nil)
    }
    
    func displayAlertVCEspaciosEnBlanco(_ espaciosEnBlanco : String){
        present(utilsDisplayAlertVCEspaciosEnBlanco(espaciosEnBlanco), animated: true, completion: nil)
    }
    
    
    
    func signUpAndPostImage(){

        let postImage = PFObject(className: self.CONSTANTES.IDNOMBRETABLAIMAGEN)
        let imageData = UIImageJPEGRepresentation(self.myImageView.image!, 0.6)
        let imageFile = PFFile(name: "image.jpg", data: imageData!)
        postImage[self.CONSTANTES.IDIMAGENURL] = imageFile
        postImage[self.CONSTANTES.USERNAMEPARSE] = PFUser.current()?.username
        
        postImage.saveInBackground(block: { (success, error) -> Void in
            if success{
                self.displayAlertVCExitoso()
            }else{
                self.displayAlertVCErrorRegistro(self.CONSTANTES.ERRORREGISTRO as NSString)
            }
            self.photoSelected = false
            self.myImageView.image = UIImage(named: "placeholderPerson.png")
        })

        self.performSegue(withIdentifier: "jumpToViewContoller", sender: self)
        
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
    
    //MARK: - GEOPOINT
    func geoPointParse(){
        PFGeoPoint.geoPointForCurrentLocation {
            (geoPoint, error) -> Void in
            if error == nil {
                let user = PFUser.current()!
                user[self.CONSTANTES.IDLOCALIZACIONPARSE] = geoPoint
                user.saveInBackground()
            }else{
                print(error!)
            }
        }
    }
    
    //MARK: - SAVE USER ID
    func saveUserID(){
        let databaseID = TOAPIDatabaseManager.sharedInstance.getSaveUser((PFUser.current()?.objectId)!)
        let myUser = PFUser.current()
        myUser![self.CONSTANTES.IDDATABASEID] = databaseID
        myUser?.saveInBackground() 
    }

    

}

//MARK: - UIImagePickerPhotoDelegate
extension RegistrerViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
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
extension RegistrerViewController : UIPickerViewDelegate, UIPickerViewDataSource{

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





