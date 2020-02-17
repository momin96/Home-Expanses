//
//  ItemFetcher.swift
//  ToDo list Swift UI
//
//  Created by Nasir Ahmed Momin on 17/02/20.
//  Copyright © 2020 Nasir Ahmed Momin. All rights reserved.
//

import Foundation

class Itemfetcher: ObservableObject {
    @Published var daysList = [ParentDocument]()
//    var daysList: [ParentDocument] = getParentDocs()

    init() {
        getDaysList()
    }
    
    func getDaysList() {
        Service.shared.getAllDocuments { [weak self] (daysList) in
            if let list = daysList {
                self?.daysList = list
            }
        }
    }
}
