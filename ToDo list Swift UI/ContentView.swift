//
//  ContentView.swift
//  ToDo list Swift UI
//
//  Created by Nasir Ahmed Momin on 05/02/20.
//  Copyright © 2020 Nasir Ahmed Momin. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showAddItemModel: Bool = false
    
    @State private var itemList = createItemList()
    
    var body: some View {
        
        NavigationView {
            VStack {
                //            List(itemList) { item in
                //                ItemCellView(itemPrice: item)
                //            }
                VStack {
                    ParentView(items: $itemList)
                }
                
                
            }
            .navigationBarTitle("Items", displayMode: .automatic)
            .navigationBarItems(trailing: Button(action: {
                self.showAddItemModel.toggle()
            }){
                Image(systemName: "plus.circle").imageScale(.large)
            })
                .sheet(isPresented: $showAddItemModel) {
                    AddItemView(viewModel: AddItemViewModel(items: self.$itemList), dismissModel: self.$showAddItemModel)
            }
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
