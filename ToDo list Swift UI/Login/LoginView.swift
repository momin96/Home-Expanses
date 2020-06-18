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
import Firebase

class LoginViewModel: ObservableObject {
    
    @Published var showAuthAlert: Bool = false
    @Published var authError: Error?
    
    var isLoggedIn: Binding<Bool>
    
    var cancellable: AnyCancellable?
    
    init(isLoggedIn: Binding<Bool>) {
        self.isLoggedIn = isLoggedIn
    }
    
    func register(dataResult: AuthDataResult) {
        LoginService().register(dataResult: dataResult)
    }
    
    func authenticate(withCredential credential: AuthCredential) {
        cancellable = AuthService().authenticate(withCredential: credential)?
            .catch({ [weak self] (error) -> Empty<AuthDataResult, Never> in
                self?.authError = error
                self?.showAuthAlert = true
                return Empty<AuthDataResult, Never>()
            })
            .eraseToAnyPublisher()
            .sink(receiveValue: { (dataResult) in
                self.register(dataResult: dataResult)
                self.isLoggedIn.wrappedValue = true
            })
    }
}

struct LoginView: View {
    
    @ObservedObject var viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack{
            GoogleSignInButton(showAuthAlert: $viewModel.showAuthAlert, authError: $viewModel.authError) { (authCredential) in
                
                guard let credential = authCredential else {
                    self.viewModel.authError = AppError.CredentailError
                    self.viewModel.showAuthAlert = true
                    return
                }
                self.viewModel.authenticate(withCredential: credential)
            }
            .frame(width: 250, height: 40)
        }
        .alert(isPresented: $viewModel.showAuthAlert) {
            
            Alert(title: Text("Login Failed"),
                  message: Text("\(self.viewModel.authError?.localizedDescription ?? "Unknown Reason")"),
                  dismissButton: .default(Text("OK"), action: {
                    self.viewModel.showAuthAlert = false
                  }))
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel(isLoggedIn: .constant(false)))
    }
}
