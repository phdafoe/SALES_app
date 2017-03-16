//
//  MenuController.swift
//  SidebarMenu
//
//  Created by Simon Ng on 2/2/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import UIKit
import MessageUI
import Parse

class MenuController: UITableViewController {
    
    //MARK: - VARIABLES LOCALES
    let CONSTANTES = Constants()
    
    
    //MARK: - IBOUTLET
    @IBOutlet weak var myNameLBL: UILabel!
    @IBOutlet weak var myImageProfileIV: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        myImageProfileIV.layer.cornerRadius = myImageProfileIV.frame.size.width / 2
        myImageProfileIV.layer.borderColor = UIColor(red: 0.71, green: 0.75, blue: 0.20, alpha: 1.0).cgColor
        myImageProfileIV.layer.borderWidth = 1.5
        myImageProfileIV.layer.shadowColor = UIColor.black.cgColor
        myImageProfileIV.layer.shadowOffset = CGSize(width: 0, height: 15)
        myImageProfileIV.clipsToBounds = true
        findAndGetDataFromImageProfile()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        rateAppTO()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if indexPath.section == 1 && indexPath.row == 2{
            tableView.deselectRow(at: indexPath, animated: true)
            sendMailToTeam()
        }
        
        if indexPath.section == 1 && indexPath.row == 3{
            tableView.deselectRow(at: indexPath, animated: true)
            showRateMe()
        }
    }
    
    //MARK: - UTILS
    func rateAppTO(){
        
        var iMinSessions = 3
        var iTryAgainSessions = 6
        
        func rateMe() {
            let neverRate = UserDefaults.standard.bool(forKey: "neverRate")
            var numLaunches = UserDefaults.standard.integer(forKey: "numLaunches") + 1
            
            if (!neverRate && (numLaunches == iMinSessions || numLaunches >= (iMinSessions + iTryAgainSessions + 1)))
            {
                showRateMe()
                numLaunches = iMinSessions + 1
            }
            UserDefaults.standard.set(numLaunches, forKey: "numLaunches")
        }
    }
    
    func showRateMe() {
        let alert = UIAlertController(title: "Valóranos", message: "Gracias por usar TusOfertas", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Valora TusOfertas", style: UIAlertActionStyle.default, handler: { alertAction in
            UIApplication.shared.open(URL(string: "itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=1107387171")!, options: [:], completionHandler: nil)
            alert.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "No Gracias", style: UIAlertActionStyle.default, handler: { alertAction in
            UserDefaults.standard.set(true, forKey: "neverRate")
            alert.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Quizá luego", style: UIAlertActionStyle.default, handler: { alertAction in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func findAndGetDataFromImageProfile(){
        let query = PFQuery(className:self.CONSTANTES.IDNOMBRETABLAIMAGEN)
        query.whereKey(self.CONSTANTES.USERNAMEPARSE, equalTo:(PFUser.current()?.username)!)
        query.findObjectsInBackground {
            (objects, error) -> Void in
            if error == nil {
                if let objects = objects {
                    for objectData in objects {
                        self.myNameLBL.text = objectData[self.CONSTANTES.USERNAMEPARSE] as? String
                        let userImageFile = objectData[self.CONSTANTES.IDIMAGENURL] as! PFFile
                        userImageFile.getDataInBackground {
                            (imageData, error) -> Void in
                            if error == nil {
                                if let imageData = imageData {
                                    let image = UIImage(data:imageData)
                                    self.myImageProfileIV.image = image
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
    }
    
    

}


//MARK: - MFMailComposeViewControllerDelegate
extension MenuController : MFMailComposeViewControllerDelegate{
    
    func sendMailToTeam(){
        
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail(){
            self.present(mailComposeViewController, animated: true, completion: nil)
        }else{
            showSendMailErrorAlert()
        }
    }
    
    //MARK: - UTILS / AUXILIARES
    func configuredMailComposeViewController() -> MFMailComposeViewController{
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients([""])
        mailComposerVC.setSubject("")
        mailComposerVC.setMessageBody("Hola Por favor envía un mail a nuestro equipo de soporte", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert(){
        let sendMailErrorAlert = UIAlertController(title: "ATENCIÓN!", message: "No se ha logrado enviar el mail", preferredStyle: .alert)
        let actionView = UIAlertAction(title: "Ok", style: .default, handler: nil)
        sendMailErrorAlert.addAction(actionView)
        present(sendMailErrorAlert, animated: true, completion: nil)
        
    }
    
    //MARK: - DELEGATE
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }

    
}
