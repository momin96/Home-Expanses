//
//  LoginView.swift
//  ToDo list Swift UI
//
//  Created by Nasir Ahmed Momin on 14/06/20.
//  Copyright © 2020 Nasir Ahmed Momin. All rights reserved.
//

import SwiftUI
import Combine

class LoginViewModel: ObservableObject {
    
}

struct LoginView: View {
    
    @ObservedObject var viewModel = LoginViewModel()
    
    @State private var showAuthAlert: Bool = false
    @State private var authError: Error?
    
    var body: some View {
        VStack{
            AuthControlView(showAuthAlert: $showAuthAlert, authError: $authError)
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
        LoginView()
    }
}
