//
//  LinkedInVC.swift
//  SocialLogin
//
//  Created by Ketan on 12/28/16.
//  Copyright © 2016 kETANpATEL. All rights reserved.
//

import UIKit

class LinkedInVC: UIViewController {

    @IBOutlet weak var btnLinkedInLogin: UIButton!
    @IBOutlet weak var activity: UIActivityIndicatorView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //IBAction Methods
    
    @IBAction func btnLinkedInLoginPressed(btnSender: UIButton) {
                
        if(btnLinkedInLogin.tag == 0) {//Login in LinkedIn
            self.activity.isHidden = false
            self.btnLinkedInLogin.isHidden = true
            
            LinkedInClass.sharedInstance().loginWithLinkedIn(viewController: self, successHandler: { (response) in
                
                self.activity.isHidden = true
                self.btnLinkedInLogin.isHidden = false
                self.btnLinkedInLogin.tag = 1
                self.btnLinkedInLogin.setTitle("Logout", for: .normal)

            }, failHandler: { (response) in
                self.activity.isHidden = true
                self.btnLinkedInLogin.isHidden = false
            })
        }
        else {//Logout from LinkedIn
            LinkedInClass.sharedInstance().logoutFromLinkedIn()
            btnLinkedInLogin.setTitle("Login", for: .normal)
        }
    }

}
