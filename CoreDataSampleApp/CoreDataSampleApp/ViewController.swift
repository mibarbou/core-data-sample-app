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
    
    var chargers: [Charger] = []
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
        tableView.register(UINib(nibName: ChargerListItemCell.identifier,
                                 bundle: .main),
                           forCellReuseIdentifier: ChargerListItemCell.identifier)
    }
    
    func setupAddChargerBarButtonItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    
    @objc func addTapped() {
        let charger1 = Charger(context: coreDataStack.managedContext)
        addedChargerNumber += 1
        charger1.id = addedChargerNumber
        charger1.name = "Charger \(addedChargerNumber)"
        charger1.model = "Unknown charger #\(addedChargerNumber)"
        coreDataStack.saveContext()
        fetchData()
    }
    
    func fetchData() {
        let fetchRequest: NSFetchRequest<Charger> = Charger.fetchRequest()
        
        do {
            chargers = try coreDataStack.managedContext.fetch(fetchRequest)
            tableView.reloadData()
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
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

        coreDataStack.managedContext.delete(chargerToRemove)
        coreDataStack.saveContext()
        fetchData()
    }
    
}

