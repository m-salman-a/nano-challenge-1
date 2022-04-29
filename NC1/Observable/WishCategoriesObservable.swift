//
//  WishCategoriesObservable.swift
//  NC1
//
//  Created by Mohammad Alfarisi on 29/04/22.
//

import Foundation

class WishCategoriesObservable: Observable {
    
    let dataStore: WishCategoryStoreProtocol
    
    private var _wishCategories = [WishCategory]()
    
    var wishCategories: [WishCategory] {
        get {
            _wishCategories
        }
    }
    
    init(dataStore: WishCategoryStoreProtocol) {
        self.dataStore = dataStore
    }
    
    func fetchWishCategories() {
        _wishCategories = dataStore.fetchWishCategories()
        
        notifyListeners()
    }
    
    func createWishCategories(category: WishCategory) {
        dataStore.createWishCategory(categoryToAdd: category)
        
        fetchWishCategories()
    }
}
