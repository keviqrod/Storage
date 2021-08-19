//
//  authoManager.swift
//  Storage
//
//  Created by Student on 8/9/21.
//

import Foundation
import FirebaseAuth

public class authoManager {
    static let shared = authoManager()
    
    // MARK: -- Public
    
    public func registerNewUser(name: String, DOB: String, email: String, password: String) {
        
        
    }
    
    public func loginNewUser(email: String?, password: String, completion: @escaping (Bool) -> Void) {
        if let email = email {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in guard authResult != nil, error == nil else {
                return
            }
            completion(true)
            }
        }
        
        
    }
    
}

