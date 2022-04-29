//
//  WishItemsObservable.swift
//  NC1
//
//  Created by Mohammad Alfarisi on 28/04/22.
//

import Foundation

class WishItemsObservable: Observable {
    
    let dataStore: WishItemStoreProtocol
    
    private var _wishItems = [WishItem]()
    
    var wishItems: [WishItem] {
        get {
            _wishItems
        }
    }
    
    init(dataStore: WishItemStoreProtocol) {
        self.dataStore = dataStore
    }
    
    func fetchWishItems() {
        _wishItems = dataStore.fetchWishItems()
        
        notifyListeners()
    }
    
    func createWishItem(item: WishItem) {
        dataStore.createWishItem(item: item)
        
        fetchWishItems()
    }
    
    func updateWishItem(id: UUID, item: WishItem) {
        dataStore.updateWishItem(id: id, item: item)
        
        fetchWishItems()
    }
    
    func deleteWishItem(id: UUID) {
        dataStore.deleteWishItem(id: id)
        
        fetchWishItems()
    }
}
