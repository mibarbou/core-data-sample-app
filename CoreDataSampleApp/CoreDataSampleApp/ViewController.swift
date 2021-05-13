//
//  ViewController.swift
//  CoreDataSampleApp
//
//  Created by Michel Barbou Salvador on 13/5/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chargers list"
        setupTable()
        setupAddChargerBarButtonItem()
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
        print("Add charger")
    }
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChargerListItemCell.identifier, for: indexPath) as? ChargerListItemCell else {
            return UITableViewCell()
        }
        cell.chargerNameLabel.text = "Charger #\(indexPath.row + 1)"
        return cell
    }
    
}

