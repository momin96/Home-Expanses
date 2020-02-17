//
//  ItemCellView.swift
//  ToDo list Swift UI
//
//  Created by Nasir Ahmed Momin on 05/02/20.
//  Copyright © 2020 Nasir Ahmed Momin. All rights reserved.
//

import SwiftUI

struct ItemCellView: View {
    
    var itemPrice: ItemPrice
    
    var body: some View {
        
        HStack {
            Text(itemPrice.itemName)
                .padding(.trailing)
                
            Spacer()
            
            Text("\(itemPrice.itemPrice)")
                .padding(.leading)
        }
        .padding(.horizontal)
    }
}

#if DEBUG
struct ItemCellView_Previews: PreviewProvider {
    static var previews: some View {
        ItemCellView(itemPrice: ItemPrice("Petrol", price: 100))
            .previewLayout(.fixed(width: 200, height: 70))
    }
}
#endif
