//
//  TwitterVC.swift
//  SocialLogin
//
//  Created by Ketan on 12/27/16.
//  Copyright © 2016 kETANpATEL. All rights reserved.
//

import UIKit

class TwitterVC: UIViewController {

    @IBOutlet weak var btnTwitterLogin: UIButton!
    @IBOutlet weak var activity: UIActivityIndicatorView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //IBAction Methods
    
    @IBAction func btnFacebookLoginPressed(btnSender: UIButton) {
        
        if(btnTwitterLogin.tag == 0) {//Login in Twitter
            
            self.activity.isHidden = false
            self.btnTwitterLogin.isHidden = true
            
            TwitterClass.sharedInstance().loginWithTwitter(viewController: self, successHandler: { (response) in
                self.activity.isHidden = true
                self.btnTwitterLogin.isHidden = false
                self.btnTwitterLogin.tag = 1
                self.btnTwitterLogin.setTitle("Logout", for: .normal)
                
            }, failHandler: { (failResponse) in
                self.activity.isHidden = true
                self.btnTwitterLogin.isHidden = false
            })
            
        }
        else {//Logout from Twitter
            
            TwitterClass.sharedInstance().logoutFromTwitter()
            btnTwitterLogin.setTitle("Login", for: .normal)
            btnTwitterLogin.tag = 0
        }
    }
    
}
