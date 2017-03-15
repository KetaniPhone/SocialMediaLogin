//
//  FacebookClass.swift
//  SocialLogin
//
//  Created by Ketan on 12/26/16.
//  Copyright © 2016 kETANpATEL. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin


typealias FBSuccessHandler = (_ success:AnyObject) -> Void
typealias FBFailHandler = (_ success:AnyObject) -> Void


class FacebookClass: NSObject {
    
    var vc: UIViewController!
    var loginFail: FBFailHandler?
    var loginSucess: FBSuccessHandler?
    
    public static let `default` = FacebookClass()
    
    //MARK: - Logout Facebook
    
    func logoutFromFacebook() {
        
        if(Reachability.isNetworkAvailable()) {
            let loginManager = LoginManager()
            loginManager.logOut()
        }
        else {
            print("No internet Connection.")
        }
    }
    
    //MARK: - Login with Facebook
    
    private func facebookAccessToken(_ viewController: UIViewController, completion: @escaping (_ token: AccessToken?, _ error: Error?) -> ()) {
        LoginManager().logIn([.publicProfile, .userFriends, .email], viewController: viewController) { loginResult in
            
            switch loginResult {
            case .failed(let error):
                print(error)
                completion(nil, error)
            case .cancelled:
                print("User cancelled login.")
                completion(nil, NSError(domain:"", code:401, userInfo:[NSLocalizedDescriptionKey: "User cancelled login."]) as Error)
            case .success( _, _, let tokenstr):
                print("Logged in! \(tokenstr)")
                completion(tokenstr, nil)
            }
        }
    }
    
    func loginWithFacebook(viewController: UIViewController, successHandler: @escaping FBSuccessHandler, failHandler: @escaping FBFailHandler) {

        vc = viewController
        loginFail = failHandler
        loginSucess = successHandler
        
        if(Reachability.isNetworkAvailable()) {
            
            if(AccessToken.current == nil) {
                facebookAccessToken(vc, completion: { (token, error) in
                    if let err = error {
                        self.loginFail!(err.localizedDescription as AnyObject)
                    } else {
                        if let token = token {
                            AccessToken.current = token
                            self.getUserInfoFromFB()
                        }
                    }
                })
            }
            else {
                //AccessToken.current = strToken
                self.getUserInfoFromFB()
            }
            
        }
        else {
            print("No internet Connection.")
            self.loginFail!("No internet Connection." as AnyObject)
        }
    }
    
    private func graphRequest(for route: String, with params: Dictionary<String, Any>, completion: @escaping (_ response: AnyObject?, _ error: Error?) -> ()) {
        
        let graphRequest = GraphRequest(graphPath: route, parameters: params)
        graphRequest.start {
            (urlResponse, requestResult) in
            
            switch requestResult {
            case .failed(let error):
                print("error in graph request:", error)
                completion(nil, error)
                break
            case .success(let graphResponse):
                
                if let responseDictionary = graphResponse.dictionaryValue {
                    print(responseDictionary)
                    completion(responseDictionary as AnyObject, nil)
                }
            }
        }
    }
    
    func getUserInfoFromFB() {
        
        let params = ["fields":"cover,picture.type(large),id,name,first_name,last_name,gender,birthday,email,location,hometown"]
        graphRequest(for: "me", with: params) { (response, error) in
            if let err = error {
                self.loginFail!(err.localizedDescription as AnyObject)
            } else {
                if let resp = response {
                    self.loginSucess!(resp)
                }
            }
        }
        
    }
    
    //MARK: - Get List Of Facebook Friends
    
    func getFacebookFriends(viewController: UIViewController, successHandler: @escaping FBSuccessHandler, failHandler: @escaping FBFailHandler) {
        
        vc = viewController
        loginFail = failHandler
        loginSucess = successHandler

        if(Reachability.isNetworkAvailable()) {
            
            if(AccessToken.current == nil) {
                
                facebookAccessToken(vc, completion: { (token, error) in
                    if let err = error {
                        self.loginFail!(err.localizedDescription as AnyObject)
                    } else {
                        if let token = token {
                            AccessToken.current = token
                            self.getUserFacebookFriendsFromFB()
                        }
                    }
                })
            }
            else {
                self.getUserFacebookFriendsFromFB()
            }
        }
        else {
            print("No internet Connection.")
            self.loginFail!("No internet Connection." as AnyObject)
        }
    }
    
    func getUserFacebookFriendsFromFB() {
        
        let params = ["fields":"cover,picture.type(large),id,name,first_name,last_name,gender,birthday,email,location,hometown"]
        graphRequest(for: "me/friends", with: params) { (response, error) in
            if let err = error {
                self.loginFail!(err.localizedDescription as AnyObject)
            } else {
                if let resp = response {
                    self.loginSucess!(resp)
                }
            }
        }
    }
}
