//
//  RoomListTableViewController.swift
//  TestApp
//
//  Created by Louis CAPELLE on 12/02/2019.
//  Copyright © 2019 Louis Capelle. All rights reserved.
//

import UIKit
import Firebase

class RoomListTableViewController: UITableViewController {

    public func alertView(title: String, message: String?){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }

    var items: [Room] = []
    var user: User!
    var userCountBarButtonItem: UIBarButtonItem!
    

    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsMultipleSelectionDuringEditing = false
        
        FirebasRef().rootUser.child((Auth.auth().currentUser?.uid)!).child("rooms").observe(.value, with: { snapshot in
            var newItems: [Room] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let roomItem = Room(snapshot: snapshot) {
                    newItems.append(roomItem)
                }
            }
            
            self.items = newItems
            self.tableView.reloadData()
        })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        let roomItem = items[indexPath.row]
        
        cell.textLabel?.text = roomItem.name
        cell.detailTextLabel?.text = roomItem.adress
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

}
