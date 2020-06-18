//
//  RootAuthView.swift
//  ToDo list Swift UI
//
//  Created by Nasir Ahmed Momin on 14/06/20.
//  Copyright © 2020 Nasir Ahmed Momin. All rights reserved.
//

import SwiftUI
import Combine
import GoogleSignIn

struct AppConfig {
    static var userLoggedInKey = "userLoggedInKey"
    
    static var collectionMain = "Expanses"
    static var collectionLoginHistory = "LoginHistory"
    
    static var fieldLastLogin = "lastLogin"
    static var fieldLastLoginString = "lastLoginString"
    static var fieldAppVersion = "appVersion"
}

class RootAuthViewModel: ObservableObject {
    
    @Published var shouldLogout: Bool = false {
        didSet {
            initiateLogout()
        }
    }
    
    @Published var showLogin: Bool = false
    
    var isUserLoggedIn: Bool {
        
        if GIDSignIn.sharedInstance()?.currentUser != nil {
            return true
        }
        
        if GIDSignIn.sharedInstance()?.hasPreviousSignIn() ?? false {
            GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        }
        
        return GIDSignIn.sharedInstance()?.currentUser != nil
        
        //        let loggedIn = UserDefaults.standard.bool(forKey: AppConfig.userLoggedInKey)
        //        return loggedIn
    }
    
    func initiateLogout() {
        if shouldLogout {
            AuthService(authType: .Google, authMode: .Logout).performGoogleLogout()
        }
    }
}

struct RootAuthView: View {
    
    @ObservedObject var viewModel = RootAuthViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isUserLoggedIn {
                HomeView(shouldLogout: $viewModel.shouldLogout)
            } else {
                LoginView(viewModel: LoginViewModel(isLoggedIn: $viewModel.showLogin))
            }
        }
    }
}

struct RootAuthView_Previews: PreviewProvider {
    static var previews: some View {
        RootAuthView()
    }
}

struct HomeView: View {
    
    @State private var selectedTab = 0
    
    var shouldLogout: Binding<Bool>
    
    init(shouldLogout: Binding<Bool>) {
        self.shouldLogout = shouldLogout
    }
    
    var body: some View {
        TabView(selection: $selectedTab){
            ContentView()
                .tabItem {
                    Text("List")
            }.tag(0)
            
            ProfileView(viewModel: ProfileViewModel(shouldLogout: shouldLogout))
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
            }.tag(1)
        }
    }
}
