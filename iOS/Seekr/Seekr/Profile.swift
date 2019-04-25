//
//  Profile.swift
//  Seekr
//
//  Created by Jensen Cody P. on 2019-04-18.
//  Copyright © 2019 Jensen Cody P. All rights reserved.
//

import UIKit

class Profile: UIViewController {
    
    
    @IBOutlet weak var profile_name: UILabel!
    @IBOutlet weak var profile_bio: UILabel!
    @IBOutlet weak var profile_email: UILabel!
    @IBOutlet weak var profile_phone: UILabel!
    @IBOutlet weak var profile_linkedin: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Dispatch.run_on_main {
            self.profile_name.text = User.reference.name;
            self.profile_bio.text = User.reference.bio;
            self.profile_email.text = User.reference.emailAddress;
            self.profile_phone.text = User.reference.phoneNumber;
            //profile_linkedin.text = User.reference.linkedin;
        }
        
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
