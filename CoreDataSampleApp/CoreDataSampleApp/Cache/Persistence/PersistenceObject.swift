//
//  PersistenceObject.swift
//  CoreDataSampleApp
//
//  Created by Michel Barbou Salvador on 13/5/21.
//

import Foundation
import CoreData

protocol PersistenceObject {
    associatedtype Object
    func create(context: NSManagedObjectContext)
}






