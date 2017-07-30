//
//  DatePickerTableCell.swift
//  QuickReminder
//
//  Created by Michal Vranec on 16/07/2017.
//  Copyright © 2017 Michal Vranec. All rights reserved.
//

import Foundation
import UIKit

protocol DatePickerTableCellProtocol: class {
    func datePickerChanged(date: Date)
    func setToDefault()
}

class DatePickerTableCell: UITableViewCell, NewReminderTableCellProtocol {


    @IBOutlet weak var datePicker: UIDatePicker!

    weak var delegate: DatePickerTableCellProtocol?
    var cellAlreadyDidLoad: Bool = false

    public func initCell(tableView: NCTableViewController) {
        tableView.delegateNR = self
        self.datePicker.minimumDate = Date().rounded(minutes: 5, rounding: .ceil)
        self.delegate?.datePickerChanged(date: self.datePicker.minimumDate!)
        self.cellAlreadyDidLoad = true
    }

    @IBAction func datePickerPrimaryActionTriggered(_ sender: Any) {
        self.datePicker.minimumDate = Date().rounded(minutes: 5, rounding: .ceil)
        if(self.datePicker.minimumDate! > self.datePicker.date) {
            self.delegate?.datePickerChanged(date: self.datePicker.minimumDate!)
        } else {
            self.delegate?.datePickerChanged(date: self.datePicker.date)
        }
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

    func reminderTextEditingChanged(text: String) {
        //not implemented
    }

}
