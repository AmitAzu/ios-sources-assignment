//
//  CacheSourceC+CoreDataProperties.swift
//  
//
//  Created by amit azulay on 23/10/2023.
//
//

import Foundation
import CoreData


extension CacheSourceC {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CacheSourceC> {
        return NSFetchRequest<CacheSourceC>(entityName: "CacheSourceC")
    }

    @NSManaged public var imageUrl: String?
    @NSManaged public var subTitle1: String?
    @NSManaged public var timestamp: Date?
    @NSManaged public var title: String?
    @NSManaged public var subTitle2: String?

}
