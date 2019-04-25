//
//  Settings.swift
//  Seekr
//
//  Created by Jensen Cody P. on 2019-04-18.
//  Copyright © 2019 Jensen Cody P. All rights reserved.
//

import UIKit

class Settings: UIViewController {
    
    
    @IBOutlet weak var settings_name: UITextField!
    @IBOutlet weak var settings_bio: UITextField!
    @IBOutlet weak var settings_email: UITextField!
    @IBOutlet weak var settings_phone: UITextField!
    @IBOutlet weak var settings_linkedin: UITextField!
    
    @IBAction func saveDown(_ sender: Any) {
        
        UFX_Database.SetUserInfo(username: User.reference.username, name: settings_name.text!, email: settings_email.text!, phone: settings_phone.text!, bio: settings_bio.text!)
        {
            result in
            
            
        }
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settings_name.text = User.reference.name;
        settings_bio.text = User.reference.bio;
        settings_email.text = User.reference.emailAddress;
        settings_phone.text = User.reference.phoneNumber
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

