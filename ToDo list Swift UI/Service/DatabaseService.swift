//
//  DatabaseService.swift
//  ToDo list Swift UI
//
//  Created by Nasir Ahmed Momin on 21/06/20.
//  Copyright © 2020 Nasir Ahmed Momin. All rights reserved.
//

import Foundation
import Firebase
import Combine

class DatabaseService {
    
    private var db = Firestore.firestore()
    
    var stopActivityIndicator = PassthroughSubject<Bool, Never>()
    
    private var userRef: DocumentReference? {
        guard let currentUser = Auth.auth().currentUser else { return nil }
        return db.collection(AppConfig.collectionMain).document(currentUser.uid)
    }
    
    init() { }
    
    func insertInDatabase(item: Item) -> AnyPublisher<DocumentReference, Error> {
        
        return Future<DocumentReference, Error> { promise in
            
            guard let userRef = self.userRef else {
                promise(.failure(AppError.userDBRefError))
                return
            }
            
            let currentTimeStamp = String(Date.epochDate)
            
            let docRef = userRef
                .collection(AppConfig.collectionToday)
                .document(currentTimeStamp)
            
            docRef.setData(item.toJSON()) { (error) in
                if let error = error {
                    print("Error \(error.localizedDescription)")
                    promise(.failure(error))
                } else {
                    print("docRef \(docRef)")
                    promise(.success(docRef))
                }
            }
        }.handleEvents(receiveSubscription: { _ in
            self.stopActivityIndicator.send(true)
        }, receiveOutput: { _ in
            self.stopActivityIndicator.send(true)
        }, receiveCompletion: { (err) in
            print("receiveCompletion Error: \(err)")
            self.stopActivityIndicator.send(false)
        })
            .eraseToAnyPublisher()
    }
    
    func fetchItems() -> AnyPublisher<[Item], Error> {
        
        return Future<[Item], Error> { promise in
            let _ = self.fetchDocuments()
                .catch({ (error) -> Empty<[QueryDocumentSnapshot], Error> in
                    promise(.failure(error))
                    return Empty<[QueryDocumentSnapshot], Error>()
                })
                .map {
                    let items =  $0.map { Item(queryDocumentSnapshot: $0) }
                    print("In map \(items)")
                    promise(.success(items))
            }
            .handleEvents()
        }
        .eraseToAnyPublisher()
    }
    
    fileprivate func fetchDocuments() -> AnyPublisher<[QueryDocumentSnapshot], Error> {
        return Future<[QueryDocumentSnapshot], Error> { promise in
            
            guard let userRef = self.userRef else {
                promise(.failure(AppError.itemFetchError))
                return
            }
            
            userRef.collection(AppConfig.collectionToday).getDocuments { (querySnapshot, error) in
                
                if let error = error {
                    return promise(.failure(error))
                }
                
                guard let documents = querySnapshot?.documents,
                    documents.count > 0
                    else {
                        promise(.failure(AppError.emptyItemList))
                        return
                }
                
                print("documents.count \(documents.count)")
                promise(.success(documents))
            }
        }
        .eraseToAnyPublisher()
    }
    
}
