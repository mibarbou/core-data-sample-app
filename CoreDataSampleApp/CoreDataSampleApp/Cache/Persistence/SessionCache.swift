//
//  SessionCache.swift
//  CoreDataSampleApp
//
//  Created by Michel Barbou Salvador on 17/5/21.
//

import Foundation
import CoreData

struct SessionCache {
    let id: String
    let chargerId: Int64
    let energy: Double
    let chargingTime: Double
}

extension SessionCache: PersistenceObject {
    typealias ManagedObject = Session
    typealias KeyType = String
    
    func primaryKey() -> String {
        id
    }
    
    func create(context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<Session> = Session.fetchRequest()
        do {
            fetchRequest.predicate = NSPredicate(format: "id == %@", primaryKey())
            let result = try context.fetch(fetchRequest)
            if let sessionAlreadySaved = result.first {
                sessionAlreadySaved.chargingTime = chargingTime
                sessionAlreadySaved.energy = energy
                print("Update session id: \(id) - chargerId: \(chargerId) - energy: \(energy) - chargingTime: \(chargingTime)")
                return
            }
            
            let session = Session(context: context)
            session.id = id
            session.chargerId = chargerId
            session.energy = energy
            session.chargingTime = chargingTime
            print("Update session id: \(id) - chargerId: \(chargerId) - energy: \(energy) - chargingTime: \(chargingTime)")
            
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
    }
    
    static func fetchData(managedObject: Session.Type, context: NSManagedObjectContext) -> [SessionCache] {
        let fetchRequest: NSFetchRequest<Session> = managedObject.fetchRequest()
        do {
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
    
    static func fetchData(managedObject: Session.Type, id: String, context: NSManagedObjectContext) -> SessionCache? {
        let fetchRequest: NSFetchRequest<Session> = managedObject.fetchRequest()
        do {
            fetchRequest.predicate = NSPredicate(format: "id == %@", id)
            let result = try context.fetch(fetchRequest)
            
            let sessions = result.map {
                SessionCache(id: $0.id ?? "",
                             chargerId: $0.chargerId,
                             energy: $0.energy,
                             chargingTime: $0.chargingTime)
            }
            return sessions.first
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
            return nil
        }
    }
    
    func delete(managedObject: Session.Type, context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<Session> = managedObject.fetchRequest()
        do {
            fetchRequest.predicate = NSPredicate(format: "id == %@", id)
            let result = try context.fetch(fetchRequest)
            
            if let sessionFound = result.first {
                context.delete(sessionFound)
            }
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
    }
}
