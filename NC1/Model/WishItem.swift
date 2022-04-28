//
//  WishItem.swift
//  NC1
//
//  Created by Mohammad Alfarisi on 28/04/22.
//

import Foundation

struct WishItem {
    var id = UUID()
    var name: String
    var price: Double
    var links: [Link]
    var likes: [String]
    var dislikes: [String]
    var category: WishCategory?
    var images = [Data]()
    
    var priceString: String {
        get {
            let formatter = NumberFormatter()
            
            formatter.numberStyle = .currency
            formatter.locale = Locale.init(identifier: "id-ID")
            
            return formatter.string(from: price as NSNumber) ?? ""
        }
    }
}
