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
}

class RootAuthViewModel: ObservableObject {
    
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
}

struct RootAuthView: View {
    
    @ObservedObject var viewModel = RootAuthViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isUserLoggedIn {
                HomeView()
            } else {
                LoginView()
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
    
    var body: some View {
        TabView(selection: $selectedTab){
            ContentView()
                .tabItem {
                    Text("List")
            }.tag(0)
            
            ProfileView()
                .tabItem {
                    Text("Profile")
            }.tag(1)
        }
    }
}
