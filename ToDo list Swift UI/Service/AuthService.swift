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
import Combine

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
    
    // New Combine way
    func authenticate(withGoogleUser user: GIDGoogleUser) -> AnyPublisher<AuthCredential, Error>? {
        
        if self.authMode == .Login {
            return Future<AuthCredential, Error> { promise in
                guard let authentication = user.authentication else {
                   return promise(.failure(AppError.CredentailError))
                }
                
                let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
                promise(.success(credential))
                
            }.eraseToAnyPublisher()
        } else if self.authMode == .logout {
            GIDSignIn.sharedInstance().signOut()
        }
        return nil
    }
    
    func performGoogleLogout() {
        GIDSignIn.sharedInstance().signOut()
    }
    
    // Old way of doing.
    func authenticate(withGoogleUser user: GIDGoogleUser, onCompletion: ((Result<AuthCredential, Error>) -> Void)? = nil) {
        
        if self.authMode == .Login {
            guard let authentication = user.authentication else {
                if let completion = onCompletion { completion(.failure(AppError.CredentailError)) }
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
            
            if let completion = onCompletion {
                completion(.success(credential))
            }
            
        } else if self.authMode == .logout {
            GIDSignIn.sharedInstance().signOut()
        }
    }
    
    //    func authenticate(withCredentail credential: AuthCredential) {
    //
    //        switch self.authType {
    //        case .Google:
    //            authenticateGoogle(withCredentail: credential)
    //        case .Facebook:
    //            authenticateFacebook(withCredentail: credential)
    //        case .Phone:
    //            authenticatePhone(withCredentail: credential)
    //        case .Apple:
    //            authenticateApple(withCredentail: credential)
    //        }
    //    }
    
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

enum AppError: Error {
    case CredentailError
}

extension AppError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .CredentailError:
            return "Credentails Error"
        }
    }
}
