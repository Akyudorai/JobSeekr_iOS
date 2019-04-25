//
//  VC_Create_Account.swift
//  Seekr
//
//  Created by Jensen Cody P. on 2019-04-11.
//  Copyright © 2019 Jensen Cody P. All rights reserved.
//

import UIKit

class VC_Create_Account: UIViewController {

    @IBOutlet weak var INPUT_user: UITextField!
    
    @IBOutlet weak var INPUT_pw: UITextField!
    
    @IBOutlet weak var INPUT_pwc: UITextField!
    
    @IBOutlet weak var OUTPUT_errorlog: UILabel!
    
    @IBAction func BTN_CreateAccount(_ sender: Any) {
        
        // Confirm that there is text in the user field
        if (INPUT_user.text == "")
        {
            if (OUTPUT_errorlog.isHidden){
                OUTPUT_errorlog.isHidden = false;
            }
            
            OUTPUT_errorlog.text = "USERNAME EMPTY"
            return
        }
        
        
        // Confirm that there is text in the password field
        if (INPUT_pw.text == "")
        {
            if (OUTPUT_errorlog.isHidden){
                OUTPUT_errorlog.isHidden = false;
            }
            
            OUTPUT_errorlog.text = "PASSWORD EMPTY"
            return
        }
        
        // Confirm that there is text in the confirm password field
        if (INPUT_pwc.text == "")
        {
            if (OUTPUT_errorlog.isHidden){
                OUTPUT_errorlog.isHidden = false;
            }
            
            OUTPUT_errorlog.text = "PLEASE CONFIRM PASSWORD"
            return
        }
        
        // Confirm that the password and confirm passwod match
        if (INPUT_pw.text != INPUT_pwc.text)
        {
            if (OUTPUT_errorlog.isHidden){
                OUTPUT_errorlog.isHidden = false;
            }
            
            OUTPUT_errorlog.text = "PASSWORDS MISMATCH"
            return
        }
        
        if (!OUTPUT_errorlog.isHidden){
            OUTPUT_errorlog.isHidden = true;
        }
    
        
        // Check if Account already exists in the databse
        
        if (OUTPUT_errorlog.isHidden) {
            OUTPUT_errorlog.isHidden = false;
            OUTPUT_errorlog.text = "";
        }
        
        UFX_Database.GetAccountFromDatabase(index: self.INPUT_user.text!)
        {
            result in
            
            if (result)
            {
                Dispatch.run_on_main{
                   self.OUTPUT_errorlog.text = "ACCOUNT ALREADY EXISTS";
                }
            }
            
            // Success.  Call php->AccountCreate
            else
            {
                Dispatch.run_on_main{
                    UFX_Database.CreateAccount(username: self.INPUT_user.text!, password: self.INPUT_pw.text!)
                    {
                        result in
                        
                        print(result);
                        
                        Dispatch.run_on_main {
                            self.OUTPUT_errorlog.text = result;
                        }
                        
                    }
                }
            }
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        OUTPUT_errorlog.isHidden = true
        OUTPUT_errorlog.text = "";
        
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
