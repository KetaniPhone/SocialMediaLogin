//
//  GmailClass.swift
//  SocialLogin
//
//  Created by Ketan on 12/26/16.
//  Copyright © 2016 kETANpATEL. All rights reserved.
//

import UIKit

typealias SuccessHandler = (_ success:AnyObject) -> Void
typealias FailHandler = (_ success:AnyObject) -> Void


class GmailClass: NSObject, GIDSignInDelegate, GIDSignInUIDelegate {
    
    var vc: UIViewController!
    var loginFail: FailHandler?
    var loginSucess: SuccessHandler?
    
    static var gmailClass: GmailClass!
    
    class func sharedInstance() -> GmailClass {
        
        if(gmailClass == nil) {
            
            //Gmail Login Setup
            
            var configureError: NSError?
            GGLContext.sharedInstance().configureWithError(&configureError)
            assert(configureError == nil, "Error configuring Google services: \(configureError)")
            
            gmailClass = GmailClass()
        }
        
        return gmailClass
    }
    
    
    func loginWithGmail(viewController: UIViewController, successHandler: @escaping SuccessHandler, failHandler: @escaping FailHandler) {

        vc = viewController
        loginFail = failHandler
        loginSucess = successHandler
        
        if(Reachability.isNetworkAvailable()) {
            GIDSignIn.sharedInstance().delegate = self
            GIDSignIn.sharedInstance().uiDelegate = self
            GIDSignIn.sharedInstance().signIn()
        }
        else {
            print("No internet Connection.")
            self.loginFail!("No internet Connection." as AnyObject)
        }
    }
    
    //****************** Gmail Login Delegate Methods *********************
    
    public func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        vc.present(viewController, animated: false, completion: nil)
    }
    
    
    public func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        vc.dismiss(animated: false, completion: nil)
    }
    
    
    //Login Success
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if (error == nil) {
            
            print("UserId     : \(user.userID)")
            print("Token      : \(user.authentication.idToken)")
            print("FullName   : \(user.profile.name)")
            print("GivenName  : \(user.profile.givenName)")
            print("Family Name: \(user.profile.familyName)")
            print("EmailId    : \(user.profile.email)")
            
            loginSucess!(user as AnyObject)
        }
        else {
            print("Error      : \(error.localizedDescription)")
            loginFail!(error.localizedDescription as AnyObject)
        }
        
    }
    
    //Login Fail
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user:GIDGoogleUser!, withError error: Error!) {
        print("Error      : \(error.localizedDescription)")
        loginFail!(error.localizedDescription as AnyObject)
    }
    
}
