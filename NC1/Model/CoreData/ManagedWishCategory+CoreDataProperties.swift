//
//  ManagedWishCategory+CoreDataProperties.swift
//  NC1
//
//  Created by Mohammad Alfarisi on 28/04/22.
//
//

import Foundation
import CoreData


extension ManagedWishCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedWishCategory> {
        return NSFetchRequest<ManagedWishCategory>(entityName: "ManagedWishCategory")
    }

    @NSManaged public var name: String?
    @NSManaged public var items: NSSet?

}

// MARK: Generated accessors for items
extension ManagedWishCategory {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: ManagedWishItem)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: ManagedWishItem)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}

extension ManagedWishCategory : Identifiable {

}
