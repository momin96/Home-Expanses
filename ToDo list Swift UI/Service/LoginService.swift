//
//  LoginService.swift
//  ToDo list Swift UI
//
//  Created by Nasir Ahmed Momin on 18/06/20.
//  Copyright © 2020 Nasir Ahmed Momin. All rights reserved.
//

import Foundation
import Firebase
import GoogleSignIn

class LoginService {
    
    var db = Firestore.firestore()
    
    func register(user: GIDGoogleUser) {
        
        let userRef =  db.collection(AppConfig.collectionMain).document(user.userID)
        
        let loginDate = Date.epochDate
        
        var fieldData = [String: Any]()
        fieldData[AppConfig.fieldLastLogin] = loginDate
        fieldData[AppConfig.fieldLastLoginString] = Date()
        
        userRef.setData(fieldData) { (error) in
            print("error \(String(describing: error))")
        }
        
        let loginHistoryRef = userRef.collection(AppConfig.collectionLoginHistory).document("\(loginDate)")
        
        var versionData = [String: Any]()
        versionData[AppConfig.fieldAppVersion] = UIApplication.version
        
        loginHistoryRef.setData(versionData) { (err) in
            print("err \(String(describing: err))")
        }
    }
}

extension Date {
    static var epochDate: Int { Int(Date().timeIntervalSince1970) }
}

extension UIApplication {
    static var release: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "Unknown"
    }
    static var build: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "Unknown"
    }
    static var version: String {
        return "v\(release) (\(build))"
    }
}
