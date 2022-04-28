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
    
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
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
    
    func createWishItem(item: WishItem) {

        let managedItem = ManagedWishItem(context: context)
        
        managedItem.fromItem(item: item)

        addLinksToManagedItem(managedItem: managedItem, links: item.links)
        
        addManagedItemToCategory(managedItem: managedItem, category: item.category)
        
        saveContext()
    }
    
    func updateWishItem(id: UUID, item: WishItem) {
        
        guard let managedItem = fetchManagedWishItem(id: id) else { return }
        
        managedItem.fromItem(item: item)

        addLinksToManagedItem(managedItem: managedItem, links: item.links)
        
        addManagedItemToCategory(managedItem: managedItem, category: item.category)
        
        saveContext()
        
    }
    
    func deleteWishItem(id: UUID) {
        
        guard let managedItem = fetchManagedWishItem(id: id) else { return }
        
        context.delete(managedItem)
        
        saveContext()
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
    
    private func addLinksToManagedItem(managedItem: ManagedWishItem, links: [Link]) {
        links.forEach {
            let managedLink = ManagedLink(context: context)
            
            managedLink.fromLink(link: $0)
            
            managedItem.addToLinks(managedLink)
        }
    }
    
    private func addManagedItemToCategory(managedItem: ManagedWishItem,
                                          category: WishCategory?) {
        guard category != nil else { return }
        
        let request = ManagedWishCategory.fetchRequest()
        
        request.predicate = NSPredicate(format: "%K LIKE %@", "name", category!.name)
        
        do {
            let managedCategory = try context.fetch(request)
            
            managedCategory.first?.addToItems(managedItem)
            
        } catch {}
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch {}
    }
}
