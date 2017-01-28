//
//  ViewController.swift
//  SocialLogin
//
//  Created by Ketan on 12/26/16.
//  Copyright © 2016 kETANpATEL. All rights reserved.
//

import UIKit

class GmailVC: UIViewController {

    @IBOutlet weak var btnGmailLogin: UIButton!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //IBAction Methods
    
    @IBAction func btnGmailLoginPressed(btnSender: UIButton) {
        
        if(btnGmailLogin.tag == 0) {//Login in Gmail
        
            self.activity.isHidden = false
            self.btnGmailLogin.isHidden = true
            
            GmailClass.sharedInstance().loginWithGmail(viewController: self, successHandler: { (response) in
                self.activity.isHidden = true
                self.btnGmailLogin.isHidden = false
                self.btnGmailLogin.tag = 1
                self.btnGmailLogin.setTitle("Logout", for: .normal)

            }, failHandler: { (failResponse) in
                
                self.activity.isHidden = true
                self.btnGmailLogin.isHidden = false
            })
            
        }
        else {//Logout from Gmail
            GIDSignIn.sharedInstance().signOut()
            btnGmailLogin.setTitle("Login", for: .normal)
            btnGmailLogin.tag = 0
        }
    }
}

