//
//  PersistenceObject.swift
//  CoreDataSampleApp
//
//  Created by Michel Barbou Salvador on 13/5/21.
//

import Foundation
import CoreData


protocol PersistenceObject {
    /// The type of the Entity NSManagedObject associated with the PersistenceObject
    associatedtype ManagedObject
    
    /// The type of the id type which we gonna query to get the specific object
    associatedtype KeyType
    
    /// The value of the primaryKey
    func primaryKey() -> KeyType
    
    /// Creates an Entity NSManagedObject to be saved
    func create(context: NSManagedObjectContext)
    
    /// Fetch all the objects for an Entity
    static func fetchData(managedObject: ManagedObject.Type, context: NSManagedObjectContext) -> [Self]
    
    /// Fetch the Persistence object for a given id
    static func fetchData(managedObject: ManagedObject.Type, id: KeyType, context: NSManagedObjectContext) -> Self?
    
    /// Delete and object
    func delete(managedObject: ManagedObject.Type, context: NSManagedObjectContext)
}



