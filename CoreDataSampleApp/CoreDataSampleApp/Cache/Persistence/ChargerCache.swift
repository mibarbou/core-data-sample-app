//
//  ChargerCache.swift
//  CoreDataSampleApp
//
//  Created by Michel Barbou Salvador on 13/5/21.
//

import Foundation
import CoreData

struct ChargerCache {
    let id: Int64
    let name: String
    let model: String
    
    init(id: Int64, name: String, model: String) {
        self.id = id
        self.name = name
        self.model = model
    }
    
    // Custom Helpers methods
    
    func fetchSessions() -> [SessionCache] {
        let fetchRequest: NSFetchRequest<Session> = Session.fetchRequest()
        let context = CoreDataStack(modelName: "Wallbox").managedContext
        do {
            fetchRequest.predicate = NSPredicate(format: "chargerId == %@", NSNumber(value: id))
            let result = try context.fetch(fetchRequest)
            
            let sessions = result.map {
                SessionCache(id: $0.id ?? "",
                             chargerId: $0.chargerId,
                             energy: $0.energy,
                             chargingTime: $0.chargingTime)
            }
            return sessions
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
            return []
        }
    }
}

// MARK - PersistenceObject Implementation

extension ChargerCache: PersistenceObject {
    typealias ManagedObject = Charger
    typealias KeyType = Int64
    
    func primaryKey() -> Int64 {
        id
    }

    func create(context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<Charger> = Charger.fetchRequest()
        do {
            fetchRequest.predicate = NSPredicate(format: "id == %@", NSNumber(value: primaryKey()))
            let result = try context.fetch(fetchRequest)
            if let chargerAlreadySaved = result.first {
                chargerAlreadySaved.name = name
                chargerAlreadySaved.model = model
                print("Update Charger id: \(id) - name: \(name) - model: \(model)")
                return
            }
            
            let charger = Charger(context: context)
            charger.id = id
            charger.name = name
            charger.model = model
            print("Created Charger id: \(id) - name: \(name) - model: \(model)")
            
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
    }
    
    static func fetchData(managedObject: Charger.Type, context: NSManagedObjectContext) -> [ChargerCache] {
        let fetchRequest: NSFetchRequest<Charger> = managedObject.fetchRequest()
        do {
            let result = try context.fetch(fetchRequest)
            
            let chargers = result.map {
                ChargerCache(id: $0.id,
                             name: $0.name ?? "",
                             model: $0.model ?? "")
            }
            return chargers
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
            return []
        }
    }
    
    static func fetchData(managedObject: Charger.Type, id: Int64, context: NSManagedObjectContext) -> ChargerCache? {
        let fetchRequest: NSFetchRequest<Charger> = managedObject.fetchRequest()
        do {
            fetchRequest.predicate = NSPredicate(format: "id == %@", NSNumber(value: id))
            let result = try context.fetch(fetchRequest)
            
            let chargers = result.map {
                ChargerCache(id: $0.id,
                             name: $0.name ?? "",
                             model: $0.model ?? "")
            }
            return chargers.first
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
            return nil
        }
    }
    
    func delete(managedObject: Charger.Type, context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<Charger> = managedObject.fetchRequest()
        do {
            fetchRequest.predicate = NSPredicate(format: "id == %@", NSNumber(value: id))
            let result = try context.fetch(fetchRequest)
            
            if let chargerFound = result.first {
                context.delete(chargerFound)
            }
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
    }
    
}

