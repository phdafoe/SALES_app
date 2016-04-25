//
//  IntroRegisterViewController.swift
//  SidebarMenu
//
//  Created by User on 9/4/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit
import Parse

class IntroRegisterViewController: UIViewController {
    
    
    //MARK: - VARIABLES LOCALES GLOBALES
    var imagenesArray = UIImageView()
    
    //MARK: - IBOUTLET
    @IBOutlet weak var myScrollDataPicture: UIScrollView!
    @IBOutlet weak var myPageControllerDataPicture: UIPageControl!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for index in 0 ..< 7{
            
            imagenesArray = UIImageView(image: UIImage(named: NSString(format: "AJ_%d.png", index) as String))
            imagenesArray.frame = CGRectMake(CGFloat(index - 1) * 320, 0, 320, 481)
            myScrollDataPicture.addSubview(imagenesArray)
        }
        
        myScrollDataPicture.delegate = self
        myScrollDataPicture.contentSize = CGSizeMake(6 * 320, 481)
        myScrollDataPicture.pagingEnabled = true
        
        myPageControllerDataPicture.numberOfPages = 6
        myPageControllerDataPicture.currentPage = 0

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Salto al ViewConreoller
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        if PFUser.currentUser() != nil{
            self.performSegueWithIdentifier("jumpToMenuViewContoller", sender: self)
        }
        
    }
    
    //MARK: - Logout App
    @IBAction func LogoutCompleted(segue: UIStoryboardSegue){
        
        PFUser.logOutInBackgroundWithBlock { (error) -> Void in
            if error != nil{
                print("Error al hacer logout")
            }else{
                print("Logout Completado")
            }
        }
    }

}

extension IntroRegisterViewController : UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let pageControllerData = CGFloat(myScrollDataPicture.contentOffset.x / myScrollDataPicture.frame.size.width)
        myPageControllerDataPicture.currentPage = Int(pageControllerData)
    }
    
}
