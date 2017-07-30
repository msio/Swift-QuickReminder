//
//  CTableViewController.swift
//  QuickReminder
//
//  Created by Michal Vranec on 20/07/2017.
//  Copyright © 2017 Michal Vranec. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CTableViewController: UITableViewController, ReminderItemTableCellProtocol {


    var items: [ReminderItem] = []
    var dataManager = DataManager()

    override func viewWillAppear(_ animated: Bool) {
        self.loadData()
    }

    func loadData() {
        self.items = self.dataManager.load(completed: true)
        tableView.reloadData()
    }

    func completedPrimaryActionTriggered(objectId: NSManagedObjectID, indexPath: IndexPath){
        self.dataManager.setIsCompleted(completed: false, objectId: objectId)
        self.items.remove(at: indexPath.row)
        let cell = tableView.cellForRow(at: indexPath) as! ReminderItemTableCell
        cell.completedButton.completed = false
        cell.completedButton.setNeedsDisplay()
        tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.left)
        tableView.reloadData()
    }

    @IBAction func sentRightBarButtonAction(_ sender: Any) {
        self.performSegue(withIdentifier: "toNotCompleted", sender: nil)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "reminderItemCell", for: indexPath) as! ReminderItemTableCell

        let item = items[indexPath.row]
        cell.label?.text = item.text
        cell.completedButton.completed = true
        cell.indexPath = indexPath
        cell.objectId = item.objectID
        cell.delegate = self
        return cell

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
}
