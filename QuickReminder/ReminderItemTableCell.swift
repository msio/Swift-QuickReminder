//
//  ReminderItemTableCell.swift
//  QuickReminder
//
//  Created by Michal Vranec on 17/07/2017.
//  Copyright © 2017 Michal Vranec. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol ReminderItemTableCellProtocol {
    func completedPrimaryActionTriggered(objectId: NSManagedObjectID,indexPath: IndexPath, button: NotCompletedButton)
}

class ReminderItemTableCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var completedButton: NotCompletedButton!


    var delegate: ReminderItemTableCellProtocol!
    var indexPath: IndexPath!
    var objectId: NSManagedObjectID!

    @IBAction func completedPrimaryActionTriggered(_ sender: Any) {
        self.delegate.completedPrimaryActionTriggered(objectId: self.objectId,indexPath: self.indexPath,button: self.completedButton)
    }
}
