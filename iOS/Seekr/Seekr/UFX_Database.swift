//
//  UFX_Database.swift
//  Seekr
//
//  Created by Jensen Cody P. on 2019-04-11.
//  Copyright © 2019 Jensen Cody P. All rights reserved.
//

import Foundation

final class UFX_Database
{
    
    static func GetPostInfo(index: String, condition: String, complete:@escaping (String)->Void)
    {
        let getURL = NSURL(string: "http://45.77.101.234/mysql/getPostingData.php");
        let getRequest = NSMutableURLRequest(url:getURL! as URL);
        getRequest.httpMethod = "POST";
        
        let getPostString = "index=\(index)&condition=\(condition)";
        getRequest.httpBody = getPostString.data(using: String.Encoding.utf8);
        
        let getTask = URLSession.shared.dataTask(with: getRequest as URLRequest) {
            (data, response, error) in
            guard let data = data else {return}
            
            complete(String(data: data, encoding: .utf8)!);
        }
        
        getTask.resume();
    }
    
    static func VerifyLoginInfo(username: String, password: String, complete:@escaping (String)->Void)
    {
        let checkURL = NSURL(string: "http://45.77.101.234/mysql/verifyLogin.php");
        let checkRequest = NSMutableURLRequest(url:checkURL! as URL);
        checkRequest.httpMethod = "POST";
        
        let checkPostString = "u=\(username)&p=\(password)";
        
        checkRequest.httpBody = checkPostString.data(using: String.Encoding.utf8);
       
        let checkTask = URLSession.shared.dataTask(with: checkRequest as URLRequest) {
            (data, response, error) in
            guard let data = data else {return}
            
            complete(String(data: data, encoding: .utf8)!)
            
        }
        
        checkTask.resume();
    }
    
    static func GetAccountFromDatabase(index: String, complete:@escaping (Bool)->Void)
    {
        let checkURL = NSURL(string: "http://45.77.101.234/mysql/checkAccount.php");
        let checkRequest = NSMutableURLRequest(url:checkURL! as URL);
        checkRequest.httpMethod = "POST";
        
        let checkPostString = "index=\(index)";
        
        checkRequest.httpBody = checkPostString.data(using: String.Encoding.utf8);
        
        var result = Bool(false);
        let checkTask = URLSession.shared.dataTask(with: checkRequest as URLRequest) {
            (data, response, error) in
            guard let data = data else {return}
            
            if (String(data: data, encoding: .utf8)! == "true")
            {
                result = true;
            }
                
            else { result = false; }
            
            complete(result);
        }
        
        checkTask.resume();
    }
    
    static func CreateAccount(username: String, password: String, complete:@escaping (Bool)->Void)
    {
        let targetURL = NSURL(string: "http://45.77.101.234/mysql/createAccount.php");
        let request = NSMutableURLRequest(url:targetURL! as URL);
        request.httpMethod = "POST";
        
        let postString = "u=\(username)&p=\(password)";
        
        request.httpBody = postString.data(using: String.Encoding.utf8);
        
        var result = Bool(false);
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            guard let data = data else {return}
            
            if (String(data: data, encoding: .utf8)! == "Successfully added")
            {
                result = true;
            }
                
            else { result = false; }
            
            complete(result);
        }
        
        task.resume();
    }
}
