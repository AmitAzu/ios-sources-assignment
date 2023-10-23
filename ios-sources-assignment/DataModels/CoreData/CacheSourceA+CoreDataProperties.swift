//
//  CacheSourceA+CoreDataProperties.swift
//  
//
//  Created by amit azulay on 23/10/2023.
//
//

import Foundation
import CoreData


extension CacheSourceA {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CacheSourceA> {
        return NSFetchRequest<CacheSourceA>(entityName: "CacheSourceA")
    }

    @NSManaged public var imageUrl: String?
    @NSManaged public var subTitle: String?
    @NSManaged public var timestamp: Date?
    @NSManaged public var title: String?

}
