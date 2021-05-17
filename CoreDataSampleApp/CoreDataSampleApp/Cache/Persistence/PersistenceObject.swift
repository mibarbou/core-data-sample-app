//
//  PersistenceObject.swift
//  CoreDataSampleApp
//
//  Created by Michel Barbou Salvador on 13/5/21.
//

import Foundation
import CoreData

protocol PersistenceObject {
    associatedtype ManagedObject
    associatedtype KeyType
    func primaryKey() -> KeyType
    func create(context: NSManagedObjectContext)
    static func fetchData(managedObject: ManagedObject.Type, context: NSManagedObjectContext) -> [Self]
    static func fetchData(managedObject: ManagedObject.Type, id: KeyType, context: NSManagedObjectContext) -> Self?
    func delete(managedObject: ManagedObject.Type, context: NSManagedObjectContext)
}



