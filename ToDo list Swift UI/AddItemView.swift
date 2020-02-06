//
//  AddItemView.swift
//  ToDo list Swift UI
//
//  Created by Nasir Ahmed Momin on 05/02/20.
//  Copyright © 2020 Nasir Ahmed Momin. All rights reserved.
//

import SwiftUI

struct AddItemView: View {
    
//    @Environment(\.presentationMode) var dismissModal
    
    @Binding var dismissModal: Bool
    
    @State private var itemField: String = ""
      @State private var priceField: String = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Spacer()
                    TextField(" Enter item", text: $itemField)
                        .padding(.vertical)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 1)
                    Spacer()

                    TextField(" Enter Price", text: $priceField)
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
                let _ = ItemPrice(self.itemField, price: Int(self.priceField) ?? 0)
//                self.dismissModal.wrappedValue.dismiss()
                self.dismissModal = false
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

struct ItemPrice: Hashable, Identifiable {
    
    var id = UUID()
    var itemName: String
    var itemPrice: Int
    
    init(_ item: String, price: Int) {
        self.itemName = item
        self.itemPrice = price
    }
}

func createItemList() -> [ItemPrice] {
    
    let i1 = ItemPrice("Petrol", price: 100)
    let i2 = ItemPrice("Kitchen", price: 286)
    let i3 = ItemPrice("Dinner", price: 120)
    let i4 = ItemPrice("Lunch", price: 200)
    let i5 = ItemPrice("breakfast", price: 25)
    let i6 = ItemPrice("Milk", price: 270)
    
    return [i1, i2, i3, i4, i5, i6]
    
}
