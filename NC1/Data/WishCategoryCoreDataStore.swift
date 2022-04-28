//
//  WishCategoryCoreDataStore.swift
//  NC1
//
//  Created by Mohammad Alfarisi on 28/04/22.
//

import Foundation
import CoreData

class WishCategoryCoreDataStore: WishCategoryStoreProtocol {
    
    // MARK: - Object Lifecycle
    
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    // MARK: - CRUD Operations
    
    func fetchWishCategories() -> [WishCategory] {
        do {
            let categories = try context.fetch(ManagedWishCategory.fetchRequest()).map {
                $0.toCategory()
            }
            
            return categories
            
        } catch {}
        
        return []
    }
    
    func createWishCategory(categoryToAdd: WishCategory) {
        ManagedWishCategory(context: context).fromCategory(category: categoryToAdd)
        
        do {
            try context.save()
            
        } catch {}
    }
}
