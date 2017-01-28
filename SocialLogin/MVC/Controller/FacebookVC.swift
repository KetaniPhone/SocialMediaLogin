//
//  FacebookVC.swift
//  SocialLogin
//
//  Created by Ketan on 12/26/16.
//  Copyright © 2016 kETANpATEL. All rights reserved.
//

import UIKit

class FacebookVC: UIViewController {

    @IBOutlet weak var btnFacebookLogin: UIButton!
    @IBOutlet weak var activity: UIActivityIndicatorView!

    @IBOutlet weak var btnFacebookFriends: UIButton!
    @IBOutlet weak var activityFriends: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //IBAction Methods
    
    @IBAction func btnFacebookLoginPressed(btnSender: UIButton) {
        
        if(btnFacebookLogin.tag == 0) {//Login in facebook
            
            self.activity.isHidden = false
            self.btnFacebookLogin.isHidden = true
            
            FacebookClass.sharedInstance().loginWithFacebook(viewController: self, successHandler: { (response) in
                self.activity.isHidden = true
                self.btnFacebookLogin.isHidden = false
                self.btnFacebookLogin.tag = 1
                self.btnFacebookFriends.isHidden = false
                self.btnFacebookLogin.setTitle("Logout", for: .normal)
                
            }, failHandler: { (failResponse) in
                self.activity.isHidden = true
                self.btnFacebookLogin.isHidden = false
            })
            
        }
        else {//Logout from facebook
            FacebookClass.sharedInstance().logoutFromFacebook()
            self.btnFacebookFriends.isHidden = true
            btnFacebookLogin.setTitle("Login", for: .normal)
            btnFacebookLogin.tag = 0
        }
    }
    
    @IBAction func btnFacebookFriendsPressed(btnSender: UIButton) {
        
        self.activityFriends.isHidden = false
        self.btnFacebookFriends.isHidden = true
        
        FacebookClass.sharedInstance().getFacebookFriends(viewController: self, successHandler: { (response) in
            self.activityFriends.isHidden = true
            self.btnFacebookFriends.isHidden = false
            
        }, failHandler: { (failResponse) in
            
            self.activityFriends.isHidden = true
            self.btnFacebookFriends.isHidden = false
        })
        
    }
    
}
