//
//  SignInListVC.swift
//  SocialLogin
//
//  Created by Ketan on 12/26/16.
//  Copyright © 2016 kETANpATEL. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
}

class SignInListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var arrLoginList = Array<String>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrLoginList.append("Gmail")
        arrLoginList.append("Facebook")
        arrLoginList.append("Twitter")
        arrLoginList.append("LinkedIn")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - UITableView Delegate Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrLoginList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ListCell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath ) as! ListCell
        cell.selectionStyle = .none
        cell.lblTitle.text = arrLoginList[indexPath.row]
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(indexPath.row == 0) {
            self.performSegue(withIdentifier: "ListToGmailSignIn", sender: self)
        }
        else if(indexPath.row == 1) {
            self.performSegue(withIdentifier: "LoginToFacebookVC", sender: self)
        }
        else if(indexPath.row == 2) {
            self.performSegue(withIdentifier: "LoginToTwitterVC", sender: self)
        }
        else if(indexPath.row == 3) {
            self.performSegue(withIdentifier: "LoginToLinkedInVC", sender: self)
        }
    }
    
}
