//
//  LinkedInClass.swift
//  SocialLogin
//
//  Created by Ketan on 12/28/16.
//  Copyright © 2016 kETANpATEL. All rights reserved.
//

import UIKit

var AppClientId: String = "AppClientId"
var AppClientSecrat: String = "AppClientSecrat"
var AppId: String = "AppId"


class LinkedInClass: NSObject {

    typealias LISuccessHandler = (_ success:AnyObject) -> Void
    typealias LIFailHandler = (_ success:AnyObject) -> Void
    
    var vc: UIViewController!
    var loginFail: LIFailHandler?
    var loginSucess: LISuccessHandler?
    
    static var linkedInClass: LinkedInClass!

    
    class func sharedInstance() -> LinkedInClass {
        
        if(linkedInClass == nil) {
            linkedInClass = LinkedInClass()
        }
        return linkedInClass
    }

    func loginWithLinkedIn(viewController: UIViewController, successHandler: @escaping LISuccessHandler, failHandler: @escaping LIFailHandler) {
        
        vc = viewController
        loginFail = failHandler
        loginSucess = successHandler
        
        if(Reachability.isNetworkAvailable()) {
            
            LISDKSessionManager.createSession(withAuth: [LISDK_BASIC_PROFILE_PERMISSION], state: nil, showGoToAppStoreDialog: true, successBlock: { (response) in
                
                LISDKAPIHelper.sharedInstance().getRequest("https://api.linkedin.com/v1/people/~", success: { (response) in

                    if let data = response?.data.data(using: String.Encoding.utf8) {
                        do {
                            
                            let dictResponse = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                            print("Authenticated  : \(dictResponse)")
                            self.loginSucess!(dictResponse as AnyObject)
                            
                        } catch {
                            print(error.localizedDescription)
                            self.loginFail!(error.localizedDescription as AnyObject)
                        }
                    }
                }, error: { (error) in
                    self.loginFail!(error?.localizedDescription as AnyObject)
                })
                
            }, errorBlock: { (error) in
                self.loginFail!(error?.localizedDescription as AnyObject)
            })
            
        }
        else {
            print("No internet Connection.")
            self.loginFail!("No internet Connection." as AnyObject)
        }
    }
    
    func logoutFromLinkedIn() {
        
        if(Reachability.isNetworkAvailable()) {
            
            if(LISDKSessionManager.hasValidSession() == true) {
                LISDKSessionManager.clearSession()
            }
            
            self.loginFail!("Logout." as AnyObject)
        }
        else {
            print("No internet Connection.")
            self.loginFail!("No internet Connection." as AnyObject)
        }
    }
    
}
