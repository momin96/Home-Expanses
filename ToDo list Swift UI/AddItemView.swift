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
    
    @ObservedObject var viewModel = AddItemViewModel()
    
    @Binding var dismissModal: Bool
    @Binding var itemList: [ItemPrice]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Spacer()
                    TextField(" Enter item", text: $viewModel.itemField)
                        .padding(.vertical)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 1)
                    Spacer()

                    TextField(" Enter Price", text: $viewModel.priceField)
                        .padding(.vertical)
                        .keyboardType(.numberPad)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 1)
                    Spacer()
                }
                .padding(.horizontal)
            }
            .navigationBarTitle("Add Item", displayMode: .inline)
            .navigationBarItems(trailing: Button("ADD") {
                print("Add item button tapped")
                
                self.viewModel.addItem()
        
//                self.dismissModal = false
//                                self.dismissModal.wrappedValue.dismiss()
            }
            .frame(width: 50.0, height: 30.0))
                
        }
    }
}

//#if DEBUG
//struct AddItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddItemView(presentAsModal: )
//    }
//}
//#endif
