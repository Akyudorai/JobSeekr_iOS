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

    @IBOutlet weak var output: UILabel!
    @IBAction func ButtonDown(_ sender: Any) {
        //output.text = "TEST"
        
        let targetURL = URL(string: "http://45.77.101.234/mysql/connectBarbershop.php")!;
        
        //let request = URLRequest(url: targetURL);
        //request.httpMethod = "POST";
        //request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        //let parameters: [String: Any] = [
        //    "condition": "test",
        //    "condition2": "test2"
        //]
        //request.httpBody = parameters.percentEscaped().data(using: .utf)
        
        // URLSessionUploadTask
        // URLSessionDownloadTask
        
        let task = URLSession.shared.dataTask(with: targetURL) {(data, response, error) in
            guard let data = data else {return}
            
            Dispatch.run_on_main {
                self.output.text = String(data: data, encoding: .utf8)!
            }
            
        }
        
        task.resume()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

