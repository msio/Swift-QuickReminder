//
//  DataManager.swift
//  QuickReminder
//
//  Created by Michal Vranec on 21/07/2017.
//  Copyright © 2017 Michal Vranec. All rights reserved.
//

import UIKit
import CoreData

class DataManager {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func load(completed: Bool) -> [ReminderItem] {
        var items:[ReminderItem] = []
        do {
             items = try context.fetch(ReminderItem.fetchRequest())
            items = items.reversed()
        } catch {
            print("Fetching Failed")
        }
        return items
    }
}
