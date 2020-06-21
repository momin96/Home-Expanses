//
//  AddItemViewModel.swift
//  ToDo list Swift UI
//
//  Created by Nasir Ahmed Momin on 14/06/20.
//  Copyright © 2020 Nasir Ahmed Momin. All rights reserved.
//

import SwiftUI

class AddItemViewModel: ObservableObject {
    
    @Published var itemField: String = ""
    @Published var priceField: String = ""
    
    var items: Binding<[Item]>
    
    init(items: Binding<[Item]>) {
        self.items = items
    }
    
    func addItem() {
        let item = Item(self.itemField, price: Int(self.priceField) ?? 0)
        self.items.wrappedValue.append(item)
        
        let dbService = DatabaseService()
        let _ = dbService.insertInDatabase(item: item)
            .map({
                print("Ref = \($0)")
            })
    }
}
