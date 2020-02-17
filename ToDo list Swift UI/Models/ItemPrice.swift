//
//  ItemPrice.swift
//  ToDo list Swift UI
//
//  Created by Nasir Ahmed Momin on 17/02/20.
//  Copyright © 2020 Nasir Ahmed Momin. All rights reserved.
//

import Foundation

struct ParentDocument: Codable {
    var sumOfPrices: Double
    var noOfEntries: Int
    
    var documents: [ItemPrice]
    
}

struct ItemPrice: Codable, Hashable, Identifiable {
    
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
    
    static func performDecode(withJSONString jsonString: String) -> ItemPrice? {
        
        guard let jsonData = jsonString.data(using: .utf8) else { return nil }
                
        do {
            let childDoc = try JSONDecoder().decode(ItemPrice.self, from: jsonData)
            return childDoc
        }
        catch (let decodeErr){
            print(decodeErr.localizedDescription)
            return nil
        }
    }
    
    static func performEncode(withItemPrice itemPrice: ItemPrice) -> String? {
        
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

func createItemList() -> [ItemPrice] {
    
    let i1 = ItemPrice("Petrol", price: 100)
    let i2 = ItemPrice("Kitchen", price: 286)
    let i3 = ItemPrice("Dinner", price: 120)
    let i4 = ItemPrice("Lunch", price: 200)
    let i5 = ItemPrice("breakfast", price: 25)
    let i6 = ItemPrice("Milk", price: 270)
    
    return [i1, i2, i3, i4, i5, i6]
    
}

extension Dictionary {
    func toJSONString() -> String? {
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted]) {
            return String(data: jsonData, encoding: .utf8)
        }
        
        return nil
    }
}
