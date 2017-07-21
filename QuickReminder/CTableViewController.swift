//
//  CTableViewController.swift
//  QuickReminder
//
//  Created by Michal Vranec on 20/07/2017.
//  Copyright © 2017 Michal Vranec. All rights reserved.
//

import Foundation
import UIKit

class CTableViewController: UITableViewController{
    
    @IBAction func sentRightBarButtonAction(_ sender: Any) {
        self.performSegue(withIdentifier: "toNotCompleted", sender: nil)
    }
}
