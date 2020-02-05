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
    
    var body: some View {
        
        let itemList = createItemList()
        return NavigationView {
            List(itemList) { item in
                ItemCellView(itemPrice: item)
            }
            .navigationBarTitle("Items", displayMode: .automatic)
            .navigationBarItems(trailing: Button("Add") {
                self.presentingModal.toggle()
                print(self.presentingModal)
            }
            .sheet(isPresented: $presentingModal,
                   onDismiss: {
                    self.presentingModal.toggle()
            },
                   content: {
                    return AddItemView()
            })
                
                .frame(width: 50.0, height: 30.0))
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
