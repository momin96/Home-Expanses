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
    
    
    func addItem() {
        
        let l = ItemPrice(self.itemField, price: Int(self.priceField) ?? 0)
//        self.itemList.append(l)
    }
    
}
