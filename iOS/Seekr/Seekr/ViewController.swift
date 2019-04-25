//
//  ViewController.swift
//  Seekr
//
//  Created by Jensen Cody P. on 2019-04-11.
//  Copyright © 2019 Jensen Cody P. All rights reserved.
//

import UIKit

final class Dispatch {
    
    private static let backgroundThreadLabel = "BackgroundThreadLabel"
    
    static func run_on_main(block: @escaping ()->Void) {
        if Thread.isMainThread {
            block()
            return
        }
        
        DispatchQueue.main.async {
            block()
        }
    }
    
    static func run_in_background(block: @escaping ()->Void) {
        DispatchQueue.init(label: Dispatch.backgroundThreadLabel).async {
            block()
        }
    }
    
}

class ViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var jobBio: UILabel!
    
    // index(0) is used as blank placeholder
    var index = 1;
    
    
    
    @IBOutlet weak var output: UILabel!
    
    @IBAction func navRightBtnDown(_ sender: Any) {
        
        if (index < 7) { index += 1; }
        else { index = 1; }
        
        print(String(index));
        
        Dispatch.run_on_main {
            self.setPostData();
        }
    }
    @IBAction func navLeftBtnDown(_ sender: Any) {
        
        if (index > 1) { index -= 1; }
        else { index = 7; }
        
        Dispatch.run_on_main {
            self.setPostData();
        }
    }
    
    @IBAction func ApplyButtonDown(_ sender: Any) {
        print(String("Applied"));
        // Send email to job owner
        
        var targetEmail = String("n01105586@humbermail.ca");
        let subject = String("APPLICANT - " + (jobTitle.text)!);
        let message = String(
            "\nApplicant: " + User.reference.name +
                "\nBio: " + User.reference.bio +
                "\nPhone Number: " + User.reference.phoneNumber +
                "\nEmail Address:  " + User.reference.emailAddress +
            "\nDoes this net me a passing grade?" +
            "\n\n\n Thanks for choosing Job Seekr!" 
        );
        
        UFX_Database.GetPostInfo(index: String(self.index), condition:"Email")
        {
            result in
            
            if (result != "") { targetEmail = result; }
                
            else { print(String("Send Failed: No Target Email")); return; }
        }
        
        UFX_Database.SendEmail(targetEmail: targetEmail, subject: subject, message: message)
        {
            result in
            
            print(result);
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Dispatch.run_on_main {
            self.setPostData();
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setPostData()
    {
        Dispatch.run_on_main {
            
            // Title
            UFX_Database.GetPostInfo(index: String(self.index), condition: "Job")
            {
                result in
                
                if (result != "")
                {
                    Dispatch.run_on_main {
                        self.jobTitle.text = result;
                    }
                }
            }
            
            // Company
            UFX_Database.GetPostInfo(index: String(self.index), condition: "Company")
            {
                result in
                
                if (result != "")
                {
                    Dispatch.run_on_main {
                        self.companyName.text = result;
                    }
                }
            }
            
            // Bio
            UFX_Database.GetPostInfo(index: String(self.index), condition: "Bio")
            {
                result in
                
                if (result != "")
                {
                    Dispatch.run_on_main {
                        self.jobBio.text = result;
                    }
                }
            }
            
            // Image
            UFX_Database.GetPostInfo(index: String(self.index), condition: "Image")
            {
                result in
                
                if (result != "")
                {
                    Dispatch.run_on_main {
                        let url = NSURL(string: "http://45.77.101.234/mysql/dbimages/seekr/" + result)!;
                        let data = NSData(contentsOf:url as URL)!;
                        let t_image  = UIImage(data: data as Data);
                        
                        self.image.image = t_image;
                    }
                }
            }
            
        }
    }
}



