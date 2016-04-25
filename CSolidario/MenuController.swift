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
        myImageProfileIV.layer.borderColor = UIColor(red: 0.71, green: 0.75, blue: 0.20, alpha: 1.0).CGColor
        myImageProfileIV.layer.borderWidth = 1.5
        myImageProfileIV.layer.shadowColor = UIColor.blackColor().CGColor
        myImageProfileIV.layer.shadowOffset = CGSizeMake(0, 15)
        myImageProfileIV.clipsToBounds = true
        findAndGetDataFromImageProfile()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        rateAppTO()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        if indexPath.section == 1 && indexPath.row == 2{
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            sendMailToTeam()
        }
        
        if indexPath.section == 1 && indexPath.row == 3{
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            showRateMe()
        }
    }
    
    //MARK: - UTILS
    func rateAppTO(){
        
        var iMinSessions = 3
        var iTryAgainSessions = 6
        
        func rateMe() {
            let neverRate = NSUserDefaults.standardUserDefaults().boolForKey("neverRate")
            var numLaunches = NSUserDefaults.standardUserDefaults().integerForKey("numLaunches") + 1
            
            if (!neverRate && (numLaunches == iMinSessions || numLaunches >= (iMinSessions + iTryAgainSessions + 1)))
            {
                showRateMe()
                numLaunches = iMinSessions + 1
            }
            NSUserDefaults.standardUserDefaults().setInteger(numLaunches, forKey: "numLaunches")
        }
    }
    
    func showRateMe() {
        let alert = UIAlertController(title: "Valóranos", message: "Gracias por usar TusOfertas", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Valora TusOfertas", style: UIAlertActionStyle.Default, handler: { alertAction in
            UIApplication.sharedApplication().openURL(NSURL(string : "itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=1007362230")!)
            alert.dismissViewControllerAnimated(true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "No Gracias", style: UIAlertActionStyle.Default, handler: { alertAction in
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "neverRate")
            alert.dismissViewControllerAnimated(true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Quizá luego", style: UIAlertActionStyle.Default, handler: { alertAction in
            alert.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func findAndGetDataFromImageProfile(){
        let query = PFQuery(className:"ImageProfile")
        query.whereKey(self.CONSTANTES.USERNAMEPARSE, equalTo:(PFUser.currentUser()?.username)!)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                if let objects = objects {
                    for objectData in objects {
                        self.myNameLBL.text = objectData[self.CONSTANTES.USERNAMEPARSE] as? String
                        let userImageFile = objectData[self.CONSTANTES.IDIMAGENURL] as! PFFile
                        userImageFile.getDataInBackgroundWithBlock {
                            (imageData: NSData?, error: NSError?) -> Void in
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
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    

}


//MARK: - MFMailComposeViewControllerDelegate
extension MenuController : MFMailComposeViewControllerDelegate{
    
    func sendMailToTeam(){
        
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail(){
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
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
        let sendMailErrorAlert = UIAlertController(title: "ATENCIÓN!", message: "No se ha logrado enviar el mail", preferredStyle: .Alert)
        let actionView = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        sendMailErrorAlert.addAction(actionView)
        presentViewController(sendMailErrorAlert, animated: true, completion: nil)
        
    }
    
    //MARK: - DELEGATE
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }

    
}
