//
//  ReminderItemTableCell.swift
//  QuickReminder
//
//  Created by Michal Vranec on 17/07/2017.
//  Copyright © 2017 Michal Vranec. All rights reserved.
//

import Foundation
import UIKit


class ReminderItemTableCell : UITableViewCell{
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var completedButton: NotCompletedButton!
    
    
    @IBAction func completedPrimaryActionTriggered(_ sender: Any) {
        self.completedButton.completed = !self.completedButton.completed
        print(self.completedButton.completed.description)
        self.setNeedsDisplay()
    }
}
