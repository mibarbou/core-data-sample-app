//
//  ViewController.swift
//  CoreDataSampleApp
//
//  Created by Michel Barbou Salvador on 13/5/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var chargers: [ChargerCache] = []
    let coreDataStack = CoreDataStack(modelName: "Wallbox")
    
    var addedChargerNumber: Int64 = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chargers list"
        setupTable()
        setupAddChargerBarButtonItem()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    func setupTable() {

    }
    
    func setupAddChargerBarButtonItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(deleteTapped))
    }
    
    @objc func addTapped() {
//        let charger1 = Charger(context: coreDataStack.managedContext)
//        addedChargerNumber += 1
//        charger1.id = addedChargerNumber
//        charger1.name = "Charger \(addedChargerNumber)"
//        charger1.model = "Unknown charger #\(addedChargerNumber)"
//        coreDataStack.saveContext()
        
        addedChargerNumber += 1
        let chargerAdded = ChargerCache(id: addedChargerNumber,
                                        name: "Charger \(addedChargerNumber)",
                                        model: "Unknown charger #\(addedChargerNumber)")
        let cache: WallboxCache = WallboxCacheDefault()
        cache.save(object: chargerAdded, update: false)
        
        fetchData()
    }
    
    @objc func deleteTapped() {
        let cache: WallboxCache = WallboxCacheDefault()
        cache.deleteAll()
        fetchData()
    }
    
    
    func fetchData() {
//        let fetchRequest: NSFetchRequest<Charger> = Charger.fetchRequest()
//
//        do {
//            chargers = try coreDataStack.managedContext.fetch(fetchRequest)
//            tableView.reloadData()
//        } catch let error as NSError {
//            print("Fetch error: \(error) description: \(error.userInfo)")
//        }
        let cache: WallboxCache = WallboxCacheDefault()
//        let id: Int64 = 6
//        guard let charger = cache.fetch(type: ChargerCache.self, id: id) else {
//            return
//        }
//        chargers = [charger]
        chargers = cache.fetchArray(type: ChargerCache.self)
        tableView.reloadData()
    }
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chargers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else {
            return UITableViewCell()
        }
        let charger = chargers[indexPath.row]
        cell.textLabel?.text = charger.model
        cell.detailTextLabel?.text = "SN: \(charger.id)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {
            return
        }
        let chargerToRemove = chargers[indexPath.row]
        let cache: WallboxCache = WallboxCacheDefault()
        cache.delete(chargerToRemove)

        fetchData()
    }
    
}

