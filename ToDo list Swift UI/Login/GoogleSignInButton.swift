//
//  AuthControlView.swift
//  ToDo list Swift UI
//
//  Created by Nasir Ahmed Momin on 14/06/20.
//  Copyright © 2020 Nasir Ahmed Momin. All rights reserved.
//

import SwiftUI
import GoogleSignIn
import FirebaseAuth
import Combine

struct GoogleSignInButton: UIViewRepresentable {
    
    var showAuthAlert: Binding<Bool>
    var authError: Binding<Error?>
    var onCompletion: ((AuthCredential?) -> Void)
    
    init(showAuthAlert: Binding<Bool>, authError: Binding<Error?>, onCompletion: @escaping ((AuthCredential?) -> Void)) {
        self.showAuthAlert = showAuthAlert
        self.authError = authError
        self.onCompletion = onCompletion
    }
    
    func makeUIView(context: Context) -> GIDSignInButton {
        
        let googleSigninButton = GIDSignInButton()
        googleSigninButton.style = .wide
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.first?.rootViewController
        GIDSignIn.sharedInstance()?.delegate = context.coordinator
        
        // DispatchQueue is required so that Button's frame gets update on next runloop
        //        DispatchQueue.main.async {
        //            let bounds = UIScreen.main.bounds
        //            let originY = bounds.height.half - googleSigninButton.frame.height.half
        //            googleSigninButton.frame.origin = CGPoint(x: 0, y: originY)
        //        }
        
        return googleSigninButton
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func updateUIView(_ uiView: GIDSignInButton, context: UIViewRepresentableContext<GoogleSignInButton>) {
        
    }
    
    class Coordinator: NSObject, GIDSignInDelegate {
        
        var control:GoogleSignInButton
        
        // To avoid Memory leaks
        private var cancellable: AnyCancellable?
        
        init(_ control:GoogleSignInButton) {
            self.control = control
        }
        
        func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
            
            if let error = error {
                control.authError.wrappedValue = error
                control.showAuthAlert.wrappedValue = true
                return
            }
            
            // New combine way
            self.cancellable = AuthService(authType: .Google, authMode: .Login)
                .authenticate(withGoogleUser: user)?
                .catch({ [weak self] (error) -> Empty<AuthCredential, Never> in
                    self?.control.authError.wrappedValue = error
                    self?.control.showAuthAlert.wrappedValue = true
                    self?.control.onCompletion(nil)
                    return Empty<AuthCredential, Never>()
                })
                .eraseToAnyPublisher()
                .sink(receiveValue: { authCredential in
                    self.control.onCompletion(authCredential)
                })
            
            // OLD way.
            //            AuthService(authType: .Google, authMode: .Login).authenticate(withGoogleUser: user) { [weak self] (result) in
            //                switch result {
            //                case .failure(let error):
            //                    self?.control.authError.wrappedValue = error
            //                    self?.control.showAuthAlert.wrappedValue = true
            //
            //                case .success(let credential):
            //                    print(credential)
            //                }
            //            }
        }
        
        func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
            print(#function)
        }
    }
}

extension CGFloat {
    var half: CGFloat { self / 2.0 }
}
