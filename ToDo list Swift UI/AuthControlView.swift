//
//  AuthControlView.swift
//  ToDo list Swift UI
//
//  Created by Nasir Ahmed Momin on 14/06/20.
//  Copyright © 2020 Nasir Ahmed Momin. All rights reserved.
//

import SwiftUI
import GoogleSignIn

struct AuthControlView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIView {
        let googleSigninButton = GIDSignInButton()
        return googleSigninButton
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    class Coordinator: NSObject, GIDSignInDelegate {
        
        var control:AuthControlView
        
        init(_ control:AuthControlView) {
            self.control = control
        }
        
        func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
            
        }
    }
}

