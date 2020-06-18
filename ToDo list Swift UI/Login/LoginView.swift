//
//  LoginView.swift
//  ToDo list Swift UI
//
//  Created by Nasir Ahmed Momin on 14/06/20.
//  Copyright © 2020 Nasir Ahmed Momin. All rights reserved.
//

import SwiftUI
import Combine
import GoogleSignIn

class LoginViewModel: ObservableObject {
    
    var isLoggedIn: Binding<Bool>
    
    init(isLoggedIn: Binding<Bool>) {
        self.isLoggedIn = isLoggedIn
    }
    
    func register(user: GIDGoogleUser) {
        LoginService().register(user: user)
    }
}

struct LoginView: View {
    
    @ObservedObject var viewModel: LoginViewModel
    
    @State private var showAuthAlert: Bool = false
    @State private var authError: Error?
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack{
            
            GoogleSignInButton(showAuthAlert: $showAuthAlert, authError: $authError) { (googleSignedUser) in
                if let user = googleSignedUser {
                    self.viewModel.isLoggedIn.wrappedValue = true
                    self.viewModel.register(user: user)
                }
            }
            .frame(width: 250, height: 40)
        }
        .alert(isPresented: $showAuthAlert) {
            
            Alert(title: Text("Login Failed"),
                  message: Text("\(self.authError?.localizedDescription ?? "Unknown Reason")"),
                  dismissButton: .default(Text("OK"), action: {
                    self.showAuthAlert = false
                  }))
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel(isLoggedIn: .constant(false)))
    }
}
