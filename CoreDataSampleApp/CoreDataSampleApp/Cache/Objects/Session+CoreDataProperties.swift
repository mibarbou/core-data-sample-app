//
//  Session+CoreDataProperties.swift
//  CoreDataSampleApp
//
//  Created by Michel Barbou Salvador on 17/5/21.
//
//

import Foundation
import CoreData


extension Session {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Session> {
        return NSFetchRequest<Session>(entityName: "Session")
    }

    @NSManaged public var chargerId: Int64
    @NSManaged public var id: String?
    @NSManaged public var energy: Double
    @NSManaged public var chargingTime: Double

}

extension Session : Identifiable {

}
