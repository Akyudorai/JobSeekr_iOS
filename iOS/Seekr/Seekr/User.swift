//
//  User.swift
//  Seekr
//
//  Created by Jensen Cody P. on 2019-04-18.
//  Copyright © 2019 Jensen Cody P. All rights reserved.
//

import Foundation

final class User {
    
    // Static Reference.
    static let reference = User()
    
    public var username: String
    public var name: String
    public var emailAddress: String
    public var phoneNumber: String
    public var bio: String
    public var linkedin: String
    
    // Initialize the singleton
    private init() {
        username = "";
        name = "";
        emailAddress = "";
        phoneNumber = "";
        bio = "";
        linkedin = "";
    }
    
    // Assigns the user reference information from the database
    public func LoadUser(username: String) -> Void {
        
        self.username = username;
        print(username);
        UFX_Database.GetUserInfo(username: username, condition: "name")
        { result in
            if (result != "") { self.name = result; }
            else { print("No Name Found"); }
        }
        
        UFX_Database.GetUserInfo(username: username, condition: "email")
        {   result in
            if (result != "") { self.emailAddress = result; }
        }
        
        UFX_Database.GetUserInfo(username: username, condition: "phone")
        {   result in
            if (result != "") { self.phoneNumber = result; }
        }
        
        UFX_Database.GetUserInfo(username: username, condition: "bio")
        {   result in
            if (result != "") { self.bio = result; }
        }
        
        print("Load User Success");
        
    }
    
    
    public func SetUser(username: String, name: String, emailAddress: String, phoneNumber: String, bio: String) -> Void {
        
        UFX_Database.SetUserInfo(username: username, name: name, email: emailAddress, phone: phoneNumber, bio: bio)
        { result in
            
        }
    }

}
