//
//  WallboxCache.swift
//  CoreDataSampleApp
//
//  Created by Michel Barbou Salvador on 13/5/21.
//

import Foundation

protocol WallboxCache {
    func fetch<T: PersistenceObject, KeyType>(type: T.Type, id: KeyType) -> T?
    func fetchArray<T: PersistenceObject>(type: T.Type) -> [T]
    func save<T: PersistenceObject>(object: T, update: Bool)
    func save<T: PersistenceObject>(objects: [T], update: Bool)
    func update<T: PersistenceObject>(object: T, update: (T))
    func delete<T: PersistenceObject>(_ object: T)
    func delete<T: PersistenceObject>(_ objects: [T])
    func deleteAll()
}

final class WallboxCacheDefault: WallboxCache {
    private let coreDataStack: CoreDataStack = CoreDataStack(modelName: "Wallbox")
    
    func fetch<T, KeyType>(type: T.Type, id: KeyType) -> T? where T : PersistenceObject {
        guard let id = id as? T.KeyType else {
            return nil
        }
        return T.fetchData(managedObject: T.ManagedObject.self, id: id, context: coreDataStack.managedContext)
    }
    
    func fetchArray<T>(type: T.Type) -> [T] where T : PersistenceObject {
        let result = T.fetchData(managedObject: T.ManagedObject.self, context: coreDataStack.managedContext)
        return result
    }
    
  
    func save<T>(object: T, update: Bool = false) where T : PersistenceObject {
        object.create(context: coreDataStack.managedContext)
        coreDataStack.saveContext()
    }
    
    func save<T>(objects: [T], update: Bool = false) where T : PersistenceObject {
        objects.forEach { $0.create(context: coreDataStack.managedContext) }
        coreDataStack.saveContext()
    }
    
    func update<T>(object: T, update: (T)) where T : PersistenceObject {
        
    }
    
    func delete<T>(_ object: T) where T : PersistenceObject {
        object.delete(managedObject: T.ManagedObject.self, context: coreDataStack.managedContext)
        coreDataStack.saveContext()
    }
    
    func delete<T>(_ objects: [T]) where T : PersistenceObject {
        objects.forEach { delete($0) }
        coreDataStack.saveContext()
    }
    
    func deleteAll() {
        coreDataStack.deleteAll()
    }
    
}
