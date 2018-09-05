//
//  UserManager.swift
//  Firebase practice
//
//  Created by Frank on 2018/9/4.
//  Copyright © 2018 Frank. All rights reserved.
//

import Foundation

class UserManager {
    static let shared = UserManager()
    
//    func getUserId() -> String? {
//        let userId = UserDefaults.standard.string(forKey: "userId")
//        return userId
//    }
    
    func getUserName() -> String? {
        let userName = UserDefaults.standard.string(forKey: "userName")
        return userName
    }
    
    func getUserEmail() -> String? {
        let userEmail = UserDefaults.standard.string(forKey: "userEmail")
        return userEmail
    }
}
