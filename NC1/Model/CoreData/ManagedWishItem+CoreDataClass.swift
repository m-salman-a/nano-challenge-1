//
//  ManagedWishItem+CoreDataClass.swift
//  NC1
//
//  Created by Mohammad Alfarisi on 28/04/22.
//
//

import Foundation
import CoreData

@objc(ManagedWishItem)
public class ManagedWishItem: NSManagedObject {

    func toItem() -> WishItem {
        var item = WishItem(id: id ?? UUID(),
                            name: name ?? "",
                            price: price,
                            links: [],
                            likes: likes ?? [],
                            dislikes: dislikes ?? [])
        
        if let links = self.links {
            item.links = (links.allObjects).map {
                (link: Any) -> Link in
                (link as! ManagedLink).toLink()
            }
        }
        
        if let category = self.category {
            item.category = category.toCategory()
        }
        
        return item
    }
    
    func fromItem(item: WishItem) {
        id = item.id
        name = item.name
        price = item.price
        likes = item.likes
        dislikes = item.dislikes
    }
}
