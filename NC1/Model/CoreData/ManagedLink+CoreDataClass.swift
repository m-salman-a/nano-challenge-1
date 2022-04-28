//
//  ManagedLink+CoreDataClass.swift
//  NC1
//
//  Created by Mohammad Alfarisi on 28/04/22.
//
//

import Foundation
import CoreData

@objc(ManagedLink)
public class ManagedLink: NSManagedObject {
    
    func toLink() -> Link {
        return Link(url: url ?? "", placeholder: placeholder ?? "")
    }
    
    func fromLink(link: Link) {
        url = link.url
        placeholder = link.placeholder
    }
}
