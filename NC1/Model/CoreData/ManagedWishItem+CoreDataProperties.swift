//
//  ManagedWishItem+CoreDataProperties.swift
//  NC1
//
//  Created by Mohammad Alfarisi on 28/04/22.
//
//

import Foundation
import CoreData


extension ManagedWishItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedWishItem> {
        return NSFetchRequest<ManagedWishItem>(entityName: "ManagedWishItem")
    }

    @NSManaged public var dislikes: [String]?
    @NSManaged public var likes: [String]?
    @NSManaged public var name: String?
    @NSManaged public var price: Double
    @NSManaged public var category: ManagedWishCategory?
    @NSManaged public var links: NSSet?
    @NSManaged public var id: UUID?
}

// MARK: Generated accessors for links
extension ManagedWishItem {

    @objc(addLinksObject:)
    @NSManaged public func addToLinks(_ value: ManagedLink)

    @objc(removeLinksObject:)
    @NSManaged public func removeFromLinks(_ value: ManagedLink)

    @objc(addLinks:)
    @NSManaged public func addToLinks(_ values: NSSet)

    @objc(removeLinks:)
    @NSManaged public func removeFromLinks(_ values: NSSet)

}

extension ManagedWishItem : Identifiable {

}
