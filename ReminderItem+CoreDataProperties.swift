//
//  ReminderItem+CoreDataProperties.swift
//  
//
//  Created by Michal Vranec on 16/07/2017.
//
//

import Foundation
import CoreData


extension ReminderItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ReminderItem> {
        return NSFetchRequest<ReminderItem>(entityName: "ReminderItem")
    }

    @NSManaged public var text: String?
    @NSManaged public var completed: Bool
    @NSManaged public var notifDate: NSDate?

}
