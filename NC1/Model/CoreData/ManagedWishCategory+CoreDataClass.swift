//
//  ManagedWishCategory+CoreDataClass.swift
//  NC1
//
//  Created by Mohammad Alfarisi on 28/04/22.
//
//

import Foundation
import CoreData

@objc(ManagedWishCategory)
public class ManagedWishCategory: NSManagedObject {
    
    func toCategory() -> WishCategory {
        return WishCategory(name: name ?? "")
    }
    
    func fromCategory(category: WishCategory) {
        name = category.name
    }
}
