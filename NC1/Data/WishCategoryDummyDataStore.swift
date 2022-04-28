//
//  WishCategoryDummyDataStore.swift
//  NC1
//
//  Created by Mohammad Alfarisi on 29/04/22.
//

import Foundation

class WishCategoryDummyDataStore: WishCategoryStoreProtocol {
    
    var items = [
        WishCategory(name: "Foo"),
        WishCategory(name: "Bar")
    ]
    
    func fetchWishCategories() -> [WishCategory] {
        return items
    }
    
    func createWishCategory(categoryToAdd: WishCategory) {
        items.append(categoryToAdd)
    }
}
