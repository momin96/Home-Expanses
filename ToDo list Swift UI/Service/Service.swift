//
//  Service.swift
//  E Com SwiftUI
//
//  Created by Nasir Ahmed Momin on 14/02/20.
//  Copyright © 2020 Nasir Ahmed Momin. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

let KEY_EXPANSES = "Expanses"

struct Service {

    static var shared = Service()
    
    private var database: Firestore
    
    init() {
        FirebaseApp.configure()
        database = Firestore.firestore()
    }
    
    func getAllDocuments() {
        database.collection(KEY_EXPANSES).getDocuments { (querySnapshot, err) in
//            print("querySnapshot  \(querySnapshot)")
//            print("err  \(err)")
            if let documents = querySnapshot?.documents {
                for doc in documents {
                    let documentId = doc.documentID
                    let data = doc.data()
                    print(data)
                    print("-----")
                    
                    self.getDocument(documentId)
                    
                }
            }
        }
    }
    
    func getDocument(_ documentId: String) {
               database.collection(KEY_EXPANSES).document(documentId).collection("Today").getDocuments { (querySnapshot, err) in
                   if let documents = querySnapshot?.documents {
                       for document in documents {
                           let docId = document.documentID
                           let str = String(describing: document.data())
                           let itemPrice = ItemPrice.decodeData(str, documentId: docId)
                           print(itemPrice as Any)
                       }
                   }
               }
           }
    
}

struct ParentDocument: Codable {
    var sumOfPrices: Double
    var noOfEntries: Int
    
    var documents: [ItemPrice]
    
}

