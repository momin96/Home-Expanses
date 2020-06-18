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
    
    func register(dataResult: AuthDataResult) {
        
        print(Auth.auth().currentUser?.displayName as Any)
        
        let info = dataResult.additionalUserInfo
        
        print(info?.providerID as Any)
        print(info?.username as Any)
        print(info?.isNewUser as Any)
        
        let currentUser = dataResult.user

        let loginDate = Date.epochDate

        let userRef =  db.collection(AppConfig.collectionMain).document(currentUser.uid)
        let loginHistoryRef = userRef.collection(AppConfig.collectionLoginHistory).document("\(loginDate)")
        
        var fieldData = [String: Any]()
        fieldData[AppConfig.fieldLastLogin] = loginDate
        fieldData[AppConfig.fieldLastLoginString] = Date()
        
        var versionData = [String: Any]()
        versionData[AppConfig.fieldAppVersion] = UIApplication.version
        
        userRef.setData(fieldData) { (error) in
            print("error \(String(describing: error))")
        }
        
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
