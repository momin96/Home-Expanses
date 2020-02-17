//
//  ParentView.swift
//  ToDo list Swift UI
//
//  Created by Nasir Ahmed Momin on 17/02/20.
//  Copyright © 2020 Nasir Ahmed Momin. All rights reserved.
//

import SwiftUI

struct ParentView: View {
    
    let days: [ParentDocument] = getParentDocs()
    
    var body: some View {
        List {
            ForEach(days) { day in
                
                Section(header: Text(day.documentId)) {
                    List (day.documents, id: \.itemName) { itemPrice in
                        ItemCellView(itemPrice: itemPrice)
                    }
                }
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


//struct ParentListView: View {
//
//    let days: [ParentDocument] = getParentDocs()
//
//    var body: some View {
//        VStack {
//            List(days) { day in
//                ParentView(day: day)
//            }
//        }
//    }
//}
