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
}

extension ChargerCache: PersistenceObject {
    typealias ManagedObject = Charger

    func create(context: NSManagedObjectContext) {
        let charger = Charger(context: context)
        charger.id = id
        charger.name = name
        charger.model = model
    }
    
    static func fetchData(managedObject: Charger.Type, context: NSManagedObjectContext) -> [ChargerCache] {
        let fetchRequest: NSFetchRequest<Charger> = managedObject.fetchRequest()
        do {
            //            fetchRequest.predicate = NSPredicate(format: "questionWasShown == %@", NSNumber(value: false))
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
    
}

