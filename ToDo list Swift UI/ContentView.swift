//
//  ContentView.swift
//  ToDo list Swift UI
//
//  Created by Nasir Ahmed Momin on 05/02/20.
//  Copyright © 2020 Nasir Ahmed Momin. All rights reserved.
//

import SwiftUI
import Combine

class ItemListViewModel: ObservableObject {
    
    let dbService = DatabaseService()
    
    @Published var itemList = createItemList()
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        
        dbService.fetchItems().receive(on: RunLoop.main).sink(receiveCompletion: {
            print($0)
        }) { items in
            print(items)
            self.itemList = items
        }.store(in: &cancellable)
    }
    
}

struct ContentView: View {
    
    @ObservedObject var viewModel = ItemListViewModel()
    
    @State private var showAddItemModel: Bool = false
        
    var body: some View {
        
        NavigationView {
            VStack {
                //            List(itemList) { item in
                //                ItemCellView(itemPrice: item)
                //            }
                VStack {
                    ParentView(items: $viewModel.itemList)
                }
                
                
            }
            .navigationBarTitle("Items", displayMode: .automatic)
            .navigationBarItems(trailing: Button(action: {
                self.showAddItemModel.toggle()
            }){
                Image(systemName: "plus.circle").imageScale(.large)
            })
                .sheet(isPresented: $showAddItemModel) {
                    AddItemView(viewModel: AddItemViewModel(items: self.$viewModel.itemList), dismissModel: self.$showAddItemModel)
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
