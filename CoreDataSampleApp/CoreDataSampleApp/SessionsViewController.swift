//
//  SessionsViewController.swift
//  CoreDataSampleApp
//
//  Created by Michel Barbou Salvador on 17/5/21.
//

import UIKit

class SessionsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var charger: ChargerCache?
    var sessions: [SessionCache] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = charger?.name ?? ""
        fetchData()
    }
    
    func fetchData() {
        if let charger = charger {
            sessions = charger.fetchSessions()
            tableView.reloadData()
        }
    }
}

extension SessionsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else {
            return UITableViewCell()
        }
        let session = sessions[indexPath.row]
        cell.textLabel?.text = "\(session.id) - chargerId"
        cell.detailTextLabel?.text = "SN: \(charger?.id ?? 0) - energy: \(session.energy) - chargingTime: \(session.chargingTime)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {
            return
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
