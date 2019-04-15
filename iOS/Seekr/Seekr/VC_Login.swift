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
            OUTPUT_errorlog.text = "Login is blank."
            return;
        }
        
        if (INPUT_pw.text == "")
        {
            OUTPUT_errorlog.text = "Password is blank."
            return;
        }
        
        UFX_Database.VerifyLoginInfo(username: self.INPUT_username.text!, password: self.INPUT_pw.text!)
        {
            result in
            
            if (result == "verified")
            {
                Dispatch.run_on_main {
                    // Move to next screen
                    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let mainViewController = storyboard.instantiateViewController(withIdentifier: "main") as! ViewController
                    self.present(mainViewController, animated: true, completion: nil);
                }
                
                
                
                
            }
            
            else if (result == "incorrect")
            {
                Dispatch.run_on_main {
                    self.OUTPUT_errorlog.text = "Incorrect Password";
                }
                
            }
            
            else
            {
                Dispatch.run_on_main {
                    self.OUTPUT_errorlog.text = "Account Doesn't Exist";
                }
                
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
