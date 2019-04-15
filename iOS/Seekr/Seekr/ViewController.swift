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
    
    var index = 0;
    let imgLinks = [
    "ubisoft.jpg",
    "naughtydog.jpg",
    "crytek.png",
    "gameloft.jpg",
    "riotgames.jpg",
    "squareenix.jpg",
    "tornbanner.jpg"
    ]
    
    @IBOutlet weak var output: UILabel!
    
    @IBAction func navRightBtnDown(_ sender: Any) {
        
        if (index < imgLinks.count - 1) { index += 1; }
        else { index = 0; }
        
        Dispatch.run_on_main {
            self.setPostData();
        }
    }
    @IBAction func navLeftBtnDown(_ sender: Any) {
        
        if (index > 0) { index -= 1; }
        else { index = imgLinks.count - 1; }
        
        Dispatch.run_on_main {
            self.setPostData();
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



