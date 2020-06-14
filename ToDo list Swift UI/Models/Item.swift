//
//  ItemPrice.swift
//  ToDo list Swift UI
//
//  Created by Nasir Ahmed Momin on 17/02/20.
//  Copyright © 2020 Nasir Ahmed Momin. All rights reserved.
//

import Foundation

//struct ParentDocument: Codable, Identifiable {
//    
//    var id = UUID()
//    
//    var sumOfPrices: Double?
//    var noOfEntries: Int?
//    var documentId: String = "1581930990"
//    var documents: [Item] = [Item]()
//    
//    init() {
//        
//    }
//    
//    static func decode(fromJSONString jsonString: String) -> ParentDocument? {
//        guard let jsonData = jsonString.data(using: .utf8) else { return nil }
//        do {
//            let parentDocument = try JSONDecoder().decode(ParentDocument.self, from: jsonData)
//            return parentDocument
//        }
//        catch (let err) {
//            print(err.localizedDescription)
//            return nil
//        }
//    }
//}

class Item: Codable, ObservableObject {

    
    var id = UUID()
    var documentId : String?
    
    // Codable properties
    var itemName: String
    var itemPrice: Int
    
    enum CodingKeys: String, CodingKey {
        case itemName = "item"
        case itemPrice = "price"
    }
    
    init(_ item: String, price: Int) {
        self.itemName = item
        self.itemPrice = price
    }
    
    static func performDecode(withJSONString jsonString: String) -> Item? {
        
        guard let jsonData = jsonString.data(using: .utf8) else { return nil }
                
        do {
            let childDoc = try JSONDecoder().decode(Item.self, from: jsonData)
            return childDoc
        }
        catch (let decodeErr){
            print(decodeErr.localizedDescription)
            return nil
        }
    }
    
    static func performEncode(withItemPrice itemPrice: Item) -> String? {
        
        do {
            let jsonData = try JSONEncoder().encode(itemPrice)
            let jsonString = String(data: jsonData, encoding: .utf8)
            return jsonString
        }
        catch (let encodeErr) {
            print(encodeErr.localizedDescription)
            return nil
        }
    }
    
}

func createItemList() -> [Item] {
    
    let i1 = Item("Petrol", price: 100)
    let i2 = Item("Kitchen", price: 286)
    let i3 = Item("Dinner", price: 120)
    let i4 = Item("Lunch", price: 200)
    let i5 = Item("breakfast", price: 25)
    let i6 = Item("Milk", price: 270)
    
    return [i1, i2, i3, i4, i5, i6]
    
}

//func getParentDoc() -> ParentDocument {
//    var pd = ParentDocument()
//    pd.documents = createItemList()
//    return pd
//}
//
//func getParentDocs() -> [ParentDocument] {
//    var pd = ParentDocument()
//    pd.documents = createItemList()
//    return [pd, pd]
//}

extension Dictionary {
    func toJSONString() -> String? {
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted]) {
            return String(data: jsonData, encoding: .utf8)
        }
        
        return nil
    }
}
