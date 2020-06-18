//
//  ProfileView.swift
//  ToDo list Swift UI
//
//  Created by Nasir Ahmed Momin on 14/06/20.
//  Copyright © 2020 Nasir Ahmed Momin. All rights reserved.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    
    var shouldLogout: Binding<Bool>
    
    init(shouldLogout: Binding<Bool>) {
        self.shouldLogout = shouldLogout
    }
    
    func logout() {
        self.shouldLogout.wrappedValue = true
    }
}

struct ProfileView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
    }
    
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
        ProfileView(viewModel: ProfileViewModel(shouldLogout: .constant(false)))
    }
}
