//
//  WishItemMemoryDataStore.swift
//  NC1
//
//  Created by Mohammad Alfarisi on 28/04/22.
//

import Foundation

class WishItemDummyDataStore: WishItemStoreProtocol {
    
    private var items = [
        WishItem(name: "Adidas asdf",
                 price: 1000000,
                 links: [],
                 likes: [],
                 dislikes: []),
        WishItem(name: "Nike wasd",
                 price: 990000000,
                 links: [],
                 likes: [],
                 dislikes: [])
    ]
    
    func fetchWishItems() -> [WishItem] {
        return items
    }
    
    func createWishItem(item: WishItem) {
        items.append(item)
    }
    
    func updateWishItem(id: UUID, item: WishItem) {
        guard var prevItem = items.first(where: { $0.id == id }) else { return }
        
        prevItem = item
        
        prevItem.id = id
    }
    
    func deleteWishItem(id: UUID) {
        items.removeAll(where: { $0.id == id })
    }
}
