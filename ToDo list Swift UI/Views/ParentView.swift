//
//  ParentView.swift
//  ToDo list Swift UI
//
//  Created by Nasir Ahmed Momin on 17/02/20.
//  Copyright © 2020 Nasir Ahmed Momin. All rights reserved.
//

import SwiftUI
import Combine

struct ParentView: View {
    
    @ObservedObject var itemfetcher = Itemfetcher()
    @Binding var items: [Item]
    var body: some View {
        VStack {
//            if itemfetcher.daysList.count == 0 {
//                Text("Loading...")
//            }
//            else {
//                DaysView(itemfetcher: itemfetcher)
//            }
            List(items) { item in
              HStack {
                Text(item.itemName)
                Text("\(item.itemPrice)")
              }
            }
        }
    }
}

#if DEBUG
struct ParentView_Previews: PreviewProvider {
    @State static var items = createItemList()
    static var previews: some View {
      return ParentView(items: $items)
    }
}
#endif

struct DaysView: View {
    
    var itemfetcher: Itemfetcher
    
    var body: some View {
        VStack {
            List(0..<10) { day in
                VStack {
//                    Section(header: Text(day.documentId)) {
//                        ForEach(day.documents ) {itemPrice in
//                            ItemCellView(itemPrice: itemPrice)
//                        }
//                    }
                    Text("TODO item above commented code")
                }
            }
        }
    }
}
