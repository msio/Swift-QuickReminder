//
//  ReminderItem.swift
//  QuickReminder
//
//  Created by Michal Vranec on 13/07/2017.
//  Copyright © 2017 Michal Vranec. All rights reserved.
//

import Foundation

class ReminderItem{
   
    var text: String
    var notifDate: Date?
    var completed: Bool
    
    public init(text: String){
        self.text = text
        self.completed = false
    }
    
    public init(text:String,notifDate:Date){
        self.text = text
        self.completed = false
        self.notifDate = notifDate
    }
    
    func setCompleted(completed:Bool){
        self.completed = completed
    }
    
}

extension ReminderItem
{
    public class func getMockData() -> [ReminderItem]
    {
        return [
            ReminderItem(text: "Milk"),
            ReminderItem(text: "Chocolate"),
            ReminderItem(text: "Light bulb"),
            ReminderItem(text: "Dog food")
        ]
    }
}
