//
//  AuthService.swift
//  ToDo list Swift UI
//
//  Created by Nasir Ahmed Momin on 14/06/20.
//  Copyright © 2020 Nasir Ahmed Momin. All rights reserved.
//

import Foundation
import GoogleSignIn
import FirebaseAuth

class AuthService{
    
    enum AuthType {
        case Google
        case Phone
        case Facebook
        case Apple
    }
    
    enum AuthMode {
        case Login
        case logout
    }
    
    var authType: AuthType
    var authMode: AuthMode
    
    init(authType: AuthType, authMode: AuthMode) {
        self.authType = authType
        self.authMode = authMode
    }
    
    func authenticate(withGoogleUser user: GIDGoogleUser) {
        
    }
    
    func authenticate(withCredentail credential: AuthCredential) {
        
        switch self.authType {
        case .Google:
            authenticateGoogle(withCredentail: credential)
        case .Facebook:
            authenticateFacebook(withCredentail: credential)
        case .Phone:
            authenticatePhone(withCredentail: credential)
        case .Apple:
            authenticateApple(withCredentail: credential)
        }
    }
    
    private func authenticateGoogle(withCredentail credential: AuthCredential) {
        if self.authMode == .Login {
            
            print(credential)
            
        } else if self.authMode == .logout {
            GIDSignIn.sharedInstance().signOut()
        }
    }
    
    // TODO: In future
    private func authenticateFacebook(withCredentail credential: AuthCredential) { }
    
    private func authenticatePhone(withCredentail credential: AuthCredential) { }
    
    private func authenticateApple(withCredentail credential: AuthCredential) { }
}