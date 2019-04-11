//
//  VC_Login.swift
//  Seekr
//
//  Created by Jensen Cody P. on 2019-04-11.
//  Copyright © 2019 Jensen Cody P. All rights reserved.
//

import UIKit

class VC_Login: UIViewController {

    @IBOutlet weak var INPUT_username: UITextField!
    @IBOutlet weak var INPUT_pw: UITextField!
    
    @IBOutlet weak var OUTPUT_errorlog: UILabel!
    
    @IBAction func BTN_Login(_ sender: Any) {
        
        if (INPUT_username.text == "")
        {
            
        }
        
        if (INPUT_pw.text == "")
        {
            
        }
        
        UFX_Database.VerifyLoginInfo(username: self.INPUT_username.text!, password: self.INPUT_pw.text!)
        {
            result in
            
            if (result == "verified")
            {
                // Move to next screen
            }
            
            else if (result == "incorrect")
            {
                self.OUTPUT_errorlog.text = "Incorrect Password";
            }
            
            else
            {
                self.OUTPUT_errorlog.text = "Account Doesn't Exist";
            }
            
            
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
