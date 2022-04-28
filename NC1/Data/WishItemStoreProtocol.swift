//
//  WishItemStoreProtcol.swift
//  NC1
//
//  Created by Mohammad Alfarisi on 28/04/22.
//

import Foundation

protocol WishItemStoreProtocol {
    func fetchWishItems() -> [WishItem]
    func createWishItem(item: WishItem)
    func updateWishItem(id: UUID, item: WishItem)
    func deleteWishItem(id: UUID)
}
