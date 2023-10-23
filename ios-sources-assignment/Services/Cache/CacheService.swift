//
//  CacheService.swift
//  ios-sources-assignment
//
//  Created by amit azulay on 23/10/2023.
//  Copyright © 2023 Chegg. All rights reserved.
//
//

import CoreData

protocol ICacheService {
    func isCacheExpired(forEntityName entityName: CacheEntity) -> Bool
    func fetchData<T: NSManagedObject>(_ entityType: T.Type) -> [T]
    func createOrUpdate<T: NSManagedObject>(_ entity: T.Type, entityName: CacheEntity, title: String) -> T
    func saveContext()
}

class CacheService: ICacheService {
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CacheData")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    func isCacheExpired(forEntityName entityName: CacheEntity) -> Bool {
        guard let cacheEntity = CacheEntity(rawValue: entityName.rawValue) else {
            return true
        }
        
        let ts = cacheEntity.timestamp
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName.rawValue)
        fetchRequest.fetchLimit = 1
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false)]
        
        do {
            if let cachedObject = try persistentContainer.viewContext.fetch(fetchRequest).first {
                if let timestamp = cachedObject.value(forKey: "timestamp") as? Date {
                    return Date().timeIntervalSince(timestamp) > ts
                }
            }
        } catch {
            print("Error fetching cached data: \(error)")
        }
        
        return true
    }
    
    func fetchData<T: NSManagedObject>(_ entityType: T.Type) -> [T] {
        guard let entityName = T.entity().name else {
            print("Error: Entity name not found for \(T.self)")
            return []
        }
        
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        let sortDescriptor = NSSortDescriptor(key: "timestamp", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let data = try persistentContainer.viewContext.fetch(fetchRequest)
            return data
        } catch {
            print("Error fetching \(entityName) data: \(error)")
            return []
        }
    }
    
    func createOrUpdate<T: NSManagedObject>(_ entity: T.Type, entityName: CacheEntity, title: String) -> T {
        if let coreObject = fetchObjectByTitle(entity, title: title) {
            return coreObject
        } else {
            return create(entity, entityName: entityName)
        }
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    private func fetchObjectByTitle<T: NSManagedObject>(_ entity: T.Type, title: String) -> T? {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: entity))
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        
        do {
            let objects = try context.fetch(fetchRequest)
            return objects.first
        } catch {
            print("Error fetching Core Data object: \(error)")
            return nil
        }
    }
    
    private func create<T: NSManagedObject>(_ entity: T.Type, entityName: CacheEntity) -> T {
        let request: NSFetchRequest<T> = T.fetchRequest() as! NSFetchRequest<T>
        request.entity = NSEntityDescription.entity(forEntityName: entityName.rawValue,
                                                    in: persistentContainer.viewContext)
        return T(context: persistentContainer.viewContext)
    }
}
