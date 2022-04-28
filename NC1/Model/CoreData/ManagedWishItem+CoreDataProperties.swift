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
    @NSManaged public var id: UUID?
    @NSManaged public var category: ManagedWishCategory?
    @NSManaged public var links: NSSet?
    @NSManaged public var images: NSSet?

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

// MARK: Generated accessors for images
extension ManagedWishItem {

    @objc(addImagesObject:)
    @NSManaged public func addToImages(_ value: ManagedImage)

    @objc(removeImagesObject:)
    @NSManaged public func removeFromImages(_ value: ManagedImage)

    @objc(addImages:)
    @NSManaged public func addToImages(_ values: NSSet)

    @objc(removeImages:)
    @NSManaged public func removeFromImages(_ values: NSSet)

}

extension ManagedWishItem : Identifiable {

}
