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
        var items: [ReminderItem] = []
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ReminderItem")
            fetchRequest.predicate = NSPredicate(format: "completed = \(completed)")
            items = try context.fetch(fetchRequest) as! [ReminderItem]
        } catch {
            print("Fetching Failed")
        }
        return items
    }

    func save(temp: TempReminderItem) {
        let item = ReminderItem(context: context)
        item.completed = temp.completed
        //item.notifDate = temp.notifDate
        item.text = temp.text
        (UIApplication.shared.delegate as! AppDelegate).saveContext()

    }

    func setIsCompleted(completed: Bool, objectId: NSManagedObjectID) {
        do {
            let item = context.object(with: objectId) as! ReminderItem
            item.setValue(true, forKey: "completed")
            try context.save()
        } catch let error {
            print(error)
        }
    }

    func delete(object: NSManagedObject) {
        context.delete(object)
    }
}
