//
//  DatePickerTableCell.swift
//  QuickReminder
//
//  Created by Michal Vranec on 16/07/2017.
//  Copyright © 2017 Michal Vranec. All rights reserved.
//

import Foundation
import UIKit

protocol DatePickerTableCellProtocol:class {
    func datePickerChanged(date:Date)
}

class DatePickerTableCell: UITableViewCell,NewReminderTableCellProtocol{
    

    @IBOutlet weak var datePicker: UIDatePicker!
    
    weak var delegate:DatePickerTableCellProtocol?
    var cellAlreadyDidLoad:Bool = false
    
    public func initCell(tableView:TableViewController){
        tableView.delegateNR = self
        self.cellAlreadyDidLoad = true;
    }
    
    @IBAction func datePickerPrimaryActionTriggered(_ sender: Any) {
        self.delegate?.datePickerChanged(date: self.datePicker.date)
    }
    
    func reminderTextPrimaryActionTriggered() {
        self.datePicker.date = Date()
    }
    
    func onOffNotifPrimaryActionTriggered(isNotifOn: Bool) {
        //not implemented
    }
    
    func reminderTextEditingDidBegin() {
        //not implemented
    }
    
    func reminderTextEditingChanged(hasText: Bool) {
        //not implemented
    }
    
}
