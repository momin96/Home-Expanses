//
//  ProfileView.swift
//  ToDo list Swift UI
//
//  Created by Nasir Ahmed Momin on 14/06/20.
//  Copyright © 2020 Nasir Ahmed Momin. All rights reserved.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    
    func logout() {
        AuthService(authType: .Google, authMode: .logout).performGoogleLogout()
    }
}

struct ProfileView: View {
    
    @ObservedObject var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationView {
            
            VStack {
                Text("Profile")
            }
            .navigationBarTitle("Profile")
            .navigationBarItems(trailing: Button(action:{
                self.viewModel.logout()
            }) {
                Text("Logout")
            })
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
