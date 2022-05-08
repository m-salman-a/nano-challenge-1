//
//  WishItemCoreDataStore.swift
//  NC1
//
//  Created by Mohammad Alfarisi on 28/04/22.
//

import Foundation
import CoreData

class WishItemCoreDataStore: WishItemStoreProtocol {
    
    // MARK: - Object Lifecycle
    
    let controller: CoreDataPersistentController
    let context: NSManagedObjectContext
    
    init(controller: CoreDataPersistentController) {
        self.controller = controller
        self.context = controller.persistentContainer.viewContext
    }
    
    // MARK: - CRUD Operations
    
    func fetchWishItems() -> [WishItem] {
        do {
            let request = ManagedWishItem.fetchRequest()
            let items = try context.fetch(request).map {
                $0.toItem()
            }
            
            return items
            
        } catch {}
        
        return []
    }
    
    func editWishItem(item: WishItem) {
        let managedItem = fetchManagedWishItem(id: item.id) ?? ManagedWishItem(context: context)
        
        managedItem.fromItem(item: item, context: context)

        addManagedItemToCategory(managedItem: managedItem, category: item.category)
        
        controller.saveContext()
    }
    
    func deleteWishItem(id: UUID) {
        guard let managedItem = fetchManagedWishItem(id: id) else { return }
        
        context.delete(managedItem)
        
        controller.saveContext()
    }
    
    // MARK: Private Helper Methods
    
    private func fetchManagedWishItem(id: UUID) -> ManagedWishItem? {
        do {
            let request = ManagedWishItem.fetchRequest()
            
            request.predicate = NSPredicate(format: "%K == %@", "id", id as CVarArg)
            
            return try context.fetch(request).first
        } catch {}
        
        return nil
    }
    
    private func addManagedItemToCategory(managedItem: ManagedWishItem,
                                          category: WishCategory?) {
        guard let category = category else {
            managedItem.category = nil
            return
        }
        
        let request = ManagedWishCategory.fetchRequest()
        
        request.predicate = NSPredicate(format: "%K LIKE %@", "name", category.name)
        
        do {
            let managedCategory = try context.fetch(request)
            
            managedCategory.first?.addToItems(managedItem)
            
        } catch {}
    }
    
}
