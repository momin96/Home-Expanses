//
//  Service.swift
//  E Com SwiftUI
//
//  Created by Nasir Ahmed Momin on 14/02/20.
//  Copyright © 2020 Nasir Ahmed Momin. All rights reserved.
//

import Foundation
import Firebase
//import FirebaseFirestore

let KEY_EXPANSES = "Expanses"
let KEY_TODAY = "Today"

struct Service {
    
    static var shared = Service()
    
    private var database: Firestore
    
    init() {
        FirebaseApp.configure()
        database = Firestore.firestore()
    }
    
//    func getAllDocuments(_ onCompletion: @escaping (([ParentDocument]?) -> Void)) {
//
//        database
//            .collection(KEY_EXPANSES)
//            .getDocuments { (querySnapshot, err) in
//
//                if let documents = querySnapshot?.documents {
//
//                    var parentDocuments = [ParentDocument]()
//
//                    let group = DispatchGroup()
//
//                    for doc in documents {
//                        group.enter()
//                        let documentId = doc.documentID
//
//                        var pd = ParentDocument()
//                        if let jsonString = doc.data().toJSONString() {
//                            pd = ParentDocument.decode(fromJSONString: jsonString) ?? ParentDocument()
//                        }
//
//                        self.getDocument(documentId) { (items) in
//                            if let list = items {
//                                pd.documents = list
//                            }
//                            parentDocuments.append(pd)
//                            group.leave()
//                        }
//
//                    }
//
//                    group.notify(queue: .main) {
//                        onCompletion(parentDocuments)
//                    }
//                }
//                else {
//                    onCompletion(nil)
//                }
//        }
//    }
    
//    func getDocument(_ documentId: String,
//                     onCompletion: @escaping (([Item]?) -> Void)) {
//
//        database
//            .collection(KEY_EXPANSES)
//            .document(documentId)
//            .collection(KEY_TODAY)
//            .getDocuments { (querySnapshot, err) in
//
//                if let documents = querySnapshot?.documents {
//
//                    var items = [Item]()
//                    for document in documents {
//                        let docId = document.documentID
//                        if let str = document.data().toJSONString() {
//                            if var itemPrice = Item.performDecode(withJSONString: str) {
//                                itemPrice.documentId = docId
//                                items.append(itemPrice)
//                            }
//                        }
//                    }
//                    onCompletion(items)
//                }
//                else {
//                    onCompletion(nil)
//                }
//        }
//    }
    
}

