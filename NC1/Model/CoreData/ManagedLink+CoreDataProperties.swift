//
//  ManagedLink+CoreDataProperties.swift
//  NC1
//
//  Created by Mohammad Alfarisi on 28/04/22.
//
//

import Foundation
import CoreData


extension ManagedLink {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedLink> {
        return NSFetchRequest<ManagedLink>(entityName: "ManagedLink")
    }

    @NSManaged public var placeholder: String?
    @NSManaged public var url: String?
    @NSManaged public var relationship: ManagedWishItem?

}

extension ManagedLink : Identifiable {

}
