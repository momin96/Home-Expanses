//
//  ContentView.swift
//  ToDo list Swift UI
//
//  Created by Nasir Ahmed Momin on 05/02/20.
//  Copyright © 2020 Nasir Ahmed Momin. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var presentingModal: Bool = false
    
    @State private var itemList = createItemList()
    
    var body: some View {
        
        NavigationView {
//            List(itemList) { item in
//                ItemCellView(itemPrice: item)
//            }
            VStack {
                ParentView()
            }
                
            .navigationBarTitle("Items", displayMode: .automatic)
            .navigationBarItems(trailing: VStack { Button("Add") {
                self.presentingModal.toggle()
                }}
            .sheet(isPresented: $presentingModal, onDismiss: {
                self.presentingModal.toggle()
                print("hi")
            }, content: {
                return AddItemView(dismissModal: self.$presentingModal, itemList: self.$itemList)
            }))
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
