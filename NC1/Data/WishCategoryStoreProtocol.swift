//
//  WishCategoryStoreProtocol.swift
//  NC1
//
//  Created by Mohammad Alfarisi on 28/04/22.
//

import Foundation

protocol WishCategoryStoreProtocol {
    func fetchWishCategories() -> [WishCategory]
    func createWishCategory(categoryToAdd: WishCategory)
}
