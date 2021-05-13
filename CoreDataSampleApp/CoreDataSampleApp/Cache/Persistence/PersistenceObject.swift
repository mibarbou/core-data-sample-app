//
//  PersistenceObject.swift
//  CoreDataSampleApp
//
//  Created by Michel Barbou Salvador on 13/5/21.
//

import Foundation
import CoreData

protocol PersistenceObject: NSManagedObject {
    associatedtype Object
    static func map(input: Object, stack: CoreDataStack) -> NSManagedObject
}



