//
//  ReminderItemTableCell.swift
//  QuickReminder
//
//  Created by Michal Vranec on 17/07/2017.
//  Copyright © 2017 Michal Vranec. All rights reserved.
//

import Foundation
import UIKit

protocol ReminderItemTableCellProtocol {
    func completedPrimaryActionTriggered(index: Int, button: NotCompletedButton)
}

class ReminderItemTableCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var completedButton: NotCompletedButton!

    var delegate: ReminderItemTableCellProtocol!
    var index: Int!

    @IBAction func completedPrimaryActionTriggered(_ sender: Any) {
        self.delegate.completedPrimaryActionTriggered(index: self.index,button: self.completedButton)
    }
}
