//
//  CacheSourceB+CoreDataProperties.swift
//  
//
//  Created by amit azulay on 23/10/2023.
//
//

import Foundation
import CoreData


extension CacheSourceB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CacheSourceB> {
        return NSFetchRequest<CacheSourceB>(entityName: "CacheSourceB")
    }

    @NSManaged public var imageUrl: String?
    @NSManaged public var subTitle: String?
    @NSManaged public var timestamp: Date?
    @NSManaged public var title: String?

}
