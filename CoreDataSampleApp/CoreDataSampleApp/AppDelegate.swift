//
//  AppDelegate.swift
//  CoreDataSampleApp
//
//  Created by Michel Barbou Salvador on 13/5/21.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        loadCache()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

extension AppDelegate {
    func loadCache() {
        loadChargersCache()
        // Comment load sessions if you don't want to load them anymore on start
        loadSessionsCache()
    }
    
    func loadChargersCache() {
        let charger1 = ChargerCache(id: 1,
                                    name: "Charger 1",
                                    model: "Pulsar")
        
        let charger2 = ChargerCache(id: 2,
                                    name: "Charger 2",
                                    model: "Pulsar Plus")
        
        let charger3 = ChargerCache(id: 3,
                                    name: "Charger 3",
                                    model: "Copper SB")
        
        let charger4 = ChargerCache(id: 4,
                                    name: "Charger 4",
                                    model: "Commander 2")
        
        let charger5 = ChargerCache(id: 5,
                                    name: "Charger 5",
                                    model: "Quasar")
        
        let charger6 = ChargerCache(id: 6,
                                    name: "Charger 6",
                                    model: "Supernova")
        
        let charger7 = ChargerCache(id: 7,
                                    name: "Charger 7",
                                    model: "Copper 2")
        
        let cache: WallboxCache = WallboxCacheDefault()
        
        let chargersToSave = [charger1, charger2, charger3, charger4, charger5, charger6, charger7]
        
        cache.save(objects: chargersToSave, update: true)
    }
    
    func loadSessionsCache() {
        var sessionsToSave: [SessionCache] = []
        for _ in 0..<100 {
            let session = SessionCache(id: UUID().uuidString,
                                       chargerId: Int64.random(in: 1...6),
                                       energy: Double.random(in: 0...100),
                                       chargingTime: Double.random(in: 15...10000))
            sessionsToSave.append(session)
        }
        let cache: WallboxCache = WallboxCacheDefault()
        cache.save(objects: sessionsToSave, update: true)
    }
    
    
}

