//
//  TwitterClass.swift
//  SocialLogin
//
//  Created by Ketan on 12/27/16.
//  Copyright © 2016 kETANpATEL. All rights reserved.
//

import UIKit
import TwitterKit
import Fabric

class TwitterClass: NSObject {
    
    var AppConsumerKey: String = "AppConsumerKey"
    var AppSecrat: String = "AppSecrat"
    var strUserId: String = ""
    
    typealias TWSuccessHandler = (_ success:AnyObject) -> Void
    typealias TWFailHandler = (_ success:AnyObject) -> Void
    
    var vc: UIViewController!
    var loginFail: TWFailHandler?
    var loginSucess: TWSuccessHandler?

    
    static var twitterClass: TwitterClass!
    
    class func sharedInstance() -> TwitterClass {
        
        if(twitterClass == nil) {
            twitterClass = TwitterClass()
        }
        return twitterClass
    }
    
    
    
    func loginWithTwitter(viewController: UIViewController, successHandler: @escaping TWSuccessHandler, failHandler: @escaping TWFailHandler) {
        
        vc = viewController
        loginFail = failHandler
        loginSucess = successHandler
        
        if(Reachability.isNetworkAvailable()) {
            
            Twitter.sharedInstance().start(withConsumerKey: AppConsumerKey, consumerSecret: AppSecrat)
            Fabric.with([Twitter.sharedInstance()])
            
            Twitter.sharedInstance().logIn(withMethods: .webBased) { (session, error) in
                
                if((session) != nil) {
                    
                    Twitter.sharedInstance().sessionStore.saveSession(withAuthToken: (session?.authToken)!, authTokenSecret: (session?.authTokenSecret)!, completion: { (session, error) in
                        
                    })
                    
                    self.strUserId = (session?.userID)!
                    
                    print("authToken    :\(session?.authToken)")
                    print("userName     :\(session?.userName)")
                    print("userID       :\(self.strUserId)")
                    
                    self.loginSucess!(session as AnyObject)
                }
                else {
                    self.loginFail!(error?.localizedDescription as AnyObject)
                }
                
            }
            
        }
        else {
            print("No internet Connection.")
            self.loginFail!("No internet Connection." as AnyObject)
        }
        
    }
    
    func logoutFromTwitter() {
        
        if(Reachability.isNetworkAvailable()) {
            Twitter.sharedInstance().sessionStore.logOutUserID(self.strUserId)
        }
        else {
            print("No internet Connection.")
            self.loginFail!("No internet Connection." as AnyObject)
        }
    }
    
}
