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
//        loadData()
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
    
    func loadData() {
        let coreDataStack = CoreDataStack(modelName: "Wallbox")
        
        let charger1 = Charger(context: coreDataStack.managedContext)
        charger1.id = 1
        charger1.name = "Charger 1"
        charger1.model = "Pulsar"
        
        let charger2 = Charger(context: coreDataStack.managedContext)
        charger2.id = 2
        charger2.name = "Charger 2"
        charger2.model = "Pulsar Plus"
        
        let charger3 = Charger(context: coreDataStack.managedContext)
        charger3.id = 3
        charger3.name = "Charger 3"
        charger3.model = "Commander 2"
        
        let charger4 = Charger(context: coreDataStack.managedContext)
        charger4.id = 4
        charger4.name = "Charger 4"
        charger4.model = "Copper SB"
        
        let charger5 = Charger(context: coreDataStack.managedContext)
        charger5.id = 5
        charger5.name = "Charger 5"
        charger5.model = "Supernova"
        
        let charger6 = Charger(context: coreDataStack.managedContext)
        charger6.id = 6
        charger6.name = "Charger 6"
        charger6.model = "Quasar"
        
        coreDataStack.saveContext()
    }


}

