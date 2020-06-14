//
//  AddItemView.swift
//  ToDo list Swift UI
//
//  Created by Nasir Ahmed Momin on 05/02/20.
//  Copyright © 2020 Nasir Ahmed Momin. All rights reserved.
//

import SwiftUI
import Combine

struct AddItemView: View {
    
    //    @Environment(\.presentationMode) var dismissModal
    
    @ObservedObject var viewModel: AddItemViewModel
    var dismissModel: Binding<Bool>
    
    init(viewModel: AddItemViewModel, dismissModel: Binding<Bool>) {
        self.viewModel = viewModel
        self.dismissModel = dismissModel
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    
                    Spacer()
                    
                    TextField(" Enter item", text: $viewModel.itemField)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Spacer()
                    
                    TextField(" Enter Price", text: $viewModel.priceField)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .padding(.vertical)
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
            .navigationBarTitle("Add Item", displayMode: .inline)
            .navigationBarItems(
                leading: HStack{
                    
                    Button(action: {
                        self.dismissModel.wrappedValue = false
                    }) {
                        Image(systemName: "multiply").imageScale(.large)
                    }
                },
                trailing: HStack{
                    Button(action: {
                        self.viewModel.addItem()
                    }) {
                        Image(systemName: "plus").imageScale(.large)
                    }
            })
        }
    }
}

#if DEBUG
struct AddItemView_Previews: PreviewProvider {
    
    static var viewModel = AddItemViewModel(items: .constant([]))
    
    static var previews: some View {
        AddItemView(viewModel: viewModel, dismissModel: .constant(false))
    }
}
#endif
