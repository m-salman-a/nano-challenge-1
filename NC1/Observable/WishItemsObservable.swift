//
//  WishItemsObservable.swift
//  NC1
//
//  Created by Mohammad Alfarisi on 28/04/22.
//

import Foundation

class WishItemsObservable: Observable {
    
    let dataStore: WishItemStoreProtocol
    
    private(set) var wishItems = [WishItem]()
    
    init(dataStore: WishItemStoreProtocol) {
        self.dataStore = dataStore
    }
    
    func fetchWishItems() {
        wishItems = dataStore.fetchWishItems()
        
        notifyListeners()
    }
    
    func editWishItem(item: WishItem) {
        dataStore.editWishItem(item: item)
        
        fetchWishItems()
    }
    
    func deleteWishItem(id: UUID) {
        dataStore.deleteWishItem(id: id)
        
        fetchWishItems()
    }
}
