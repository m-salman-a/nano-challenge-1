//
//  ManagedImage+CoreDataClass.swift
//  NC1
//
//  Created by Mohammad Alfarisi on 28/04/22.
//
//

import Foundation
import CoreData

@objc(ManagedImage)
public class ManagedImage: NSManagedObject {
    
    func toImage() -> Data {
       return Data(image ?? Data())
    }
    
    func fromImage(data: Data) {
        image = data
    }
    
}
