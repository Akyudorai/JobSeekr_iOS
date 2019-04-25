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
    
    // Sends an email through Humber's Munro Servers.  Currently only works with humbermail.ca and humber.ca email addresses
    static func SendEmail(targetEmail: String, subject: String, message: String, complete:@escaping (String)->Void)
    {
        print("Target: " + targetEmail);
        print("Subject: " + subject);
        print("Message: " + message);
        
        let sendURL = NSURL(string: "http://munro.humber.ca/~n01105586/sendEmail.php");
        let sendRequest = NSMutableURLRequest(url:sendURL! as URL);
        sendRequest.httpMethod = "POST";
        
        let sendPostString = "toAddress=\(targetEmail)&subject=\(subject)&message=\(message)";
        sendRequest.httpBody = sendPostString.data(using: String.Encoding.utf8);
        
        let sendTask = URLSession.shared.dataTask(with: sendRequest as URLRequest) {
            (data, response, error) in
            guard let data = data else {return}
            
            complete(String(data: data, encoding: .utf8)!);
        }
        
        sendTask.resume();
    }
    
    // Gets the information from the database about the user and assigns the variables to the static user reference on load
    static func GetUserInfo(username: String, condition: String, complete:@escaping (String)->Void)
    {
        let getURL = NSURL(string: "http://45.77.101.234/mysql/getUserInfo.php");
        let getRequest = NSMutableURLRequest(url:getURL! as URL);
        getRequest.httpMethod = "POST";
        
        let getPostString = "username=\(index)&condition=\(condition)";
        getRequest.httpBody = getPostString.data(using: String.Encoding.utf8);
        
        let getTask = URLSession.shared.dataTask(with: getRequest as URLRequest) {
            (data, response, error) in
            guard let data = data else {return}
            
            complete(String(data: data, encoding: .utf8)!);
        }
        
        getTask.resume();
    }
    
    // Currently not working for some reason.
    // Is supposed to set the users current information and assign it to database, but it's not
    // even reaching the php script for some reason.  I know the issue is somewhere in swift though.
    static func SetUserInfo(username: String, name: String, email: String, phone: String, bio: String, complete:@escaping (String)->Void)
    {
        print(name);
        print(email);
        print(phone);
        print(bio);
        
        let setUsrURL = NSURL(string: "http://45.77.101.234/mysql/setUserInfo.php");
        let setUsrRequest = NSMutableURLRequest(url:setUsrURL! as URL);
        setUsrRequest.httpMethod = "POST";
        
        let setUsrPostString = "username=\(username)&name=\(name)&email=\(email)&phone=\(phone)&bio=\(bio)";
        setUsrRequest.httpBody = setUsrPostString.data(using: String.Encoding.utf8);
        
        let setUsrTask = URLSession.shared.dataTask(with: setUsrRequest as URLRequest) {
            (data, response, error) in
            guard let data = data else {return}
            
            complete(String(data: data, encoding: .utf8)!);
        }
        
        setUsrTask.resume();
    }
    
    // Gets the information about a job posting from the database and returns the resulting information as a string
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
    
    // Checks to confirm if the indexed account exists in the database.
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
    
    // Creates an account within the database that can be used to access the rest of the application.
    static func CreateAccount(username: String, password: String, complete:@escaping (String)->Void)
    {
        print(username);
        print(password);
        
        let targetURL = NSURL(string: "http://45.77.101.234/mysql/createAccount.php");
        let request = NSMutableURLRequest(url:targetURL! as URL);
        request.httpMethod = "POST";
        
        let postString = "u=\(username)&p=\(password)";
        
        request.httpBody = postString.data(using: String.Encoding.utf8);
        
        //var result = Bool(false);
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            guard let data = data else {return}
            
            
            
            let s = String(data: data, encoding: .utf8)!
            print(s);
            
            complete(s);
        }
        
        task.resume();
    }
}
