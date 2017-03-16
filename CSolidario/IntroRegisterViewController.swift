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
            imagenesArray.frame = CGRect(x: CGFloat(index - 1) * 320, y: 0, width: 320, height: 481)
            myScrollDataPicture.addSubview(imagenesArray)
        }
        
        myScrollDataPicture.delegate = self
        myScrollDataPicture.contentSize = CGSize(width: 6 * 320, height: 481)
        myScrollDataPicture.isPagingEnabled = true
        
        myPageControllerDataPicture.numberOfPages = 6
        myPageControllerDataPicture.currentPage = 0

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Salto al ViewConreoller
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if PFUser.current() != nil{
            self.performSegue(withIdentifier: "jumpToMenuViewContoller", sender: self)
        }
        
    }
    
    //MARK: - Logout App
    @IBAction func LogoutCompleted(_ segue: UIStoryboardSegue){
        
        PFUser.logOutInBackground { (error) -> Void in
            if error != nil{
                print("Error al hacer logout")
            }else{
                print("Logout Completado")
            }
        }
    }

}

extension IntroRegisterViewController : UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageControllerData = CGFloat(myScrollDataPicture.contentOffset.x / myScrollDataPicture.frame.size.width)
        myPageControllerDataPicture.currentPage = Int(pageControllerData)
    }
    
}
