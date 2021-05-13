//
//  ChargerCache.swift
//  CoreDataSampleApp
//
//  Created by Michel Barbou Salvador on 13/5/21.
//

import Foundation

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

