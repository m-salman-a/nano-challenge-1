//
//  ManagedImage+CoreDataProperties.swift
//  NC1
//
//  Created by Mohammad Alfarisi on 28/04/22.
//
//

import Foundation
import CoreData


extension ManagedImage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedImage> {
        return NSFetchRequest<ManagedImage>(entityName: "ManagedImage")
    }

    @NSManaged public var image: Data?
    @NSManaged public var relationship: ManagedWishItem?

}

extension ManagedImage : Identifiable {

}
