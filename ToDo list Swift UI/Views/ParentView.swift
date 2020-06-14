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
        
    var body: some View {
        VStack {
            if itemfetcher.daysList.count == 0 {
                Text("Loading...")
            }
            else {
                DaysView(itemfetcher: itemfetcher)
            }
        }
    }
}

#if DEBUG
struct ParentView_Previews: PreviewProvider {
    static var previews: some View {
        ParentView()
    }
}
#endif

struct DaysView: View {
    
    var itemfetcher: Itemfetcher
    
    var body: some View {
        VStack {
            List(itemfetcher.daysList) { day in
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
