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
    
    
    // Add a generic Charger
    @objc func addTapped() {
        addedChargerNumber += 1
        let chargerAdded = ChargerCache(id: addedChargerNumber,
                                        name: "Charger \(addedChargerNumber)",
                                        model: "Unknown charger #\(addedChargerNumber)")
        let cache: WallboxCache = WallboxCacheDefault.shared
        cache.save(object: chargerAdded, update: false)
        
        fetchData()
    }
    
    // Delete all Database
    @objc func deleteTapped() {
        let cache: WallboxCache = WallboxCacheDefault.shared
        cache.deleteAll()
        fetchData()
    }
    
    
    func fetchData() {
        let cache: WallboxCache = WallboxCacheDefault.shared
        chargers = cache.fetchArray(type: ChargerCache.self)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sessions" {
            guard let charger = sender as? ChargerCache else {
                return
            }
            let sessionsVC = segue.destination as! SessionsViewController
            sessionsVC.charger = charger
        }
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
        let cache: WallboxCache = WallboxCacheDefault.shared
        cache.delete(chargerToRemove)

        fetchData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chargerSelected = chargers[indexPath.row]
        let cache: WallboxCache = WallboxCacheDefault.shared
        // not need it, but implemented to test the fetch object by id.
        guard let charger = cache.fetch(type: ChargerCache.self, id: chargerSelected.primaryKey()) else {
            return
        }
        print("Charger Selected id: \(charger.id) - name: \(charger.name) - model: \(charger.model)")
        
        self.performSegue(withIdentifier: "sessions", sender: chargerSelected)
    }
    
}

