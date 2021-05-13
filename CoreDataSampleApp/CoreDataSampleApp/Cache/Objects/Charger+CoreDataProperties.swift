//
//  Charger+CoreDataProperties.swift
//  CoreDataSampleApp
//
//  Created by Michel Barbou Salvador on 13/5/21.
//
//

import Foundation
import CoreData


extension Charger {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Charger> {
        return NSFetchRequest<Charger>(entityName: "Charger")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var model: String?

}

extension Charger : Identifiable {

}
