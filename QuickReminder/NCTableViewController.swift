//
//  ViewController.swift
//  QuickReminder
//
//  Created by Michael on 7/9/17.
//  Copyright © 2017 Michal Vranec. All rights reserved.
//

import UIKit
import CoreData

enum RightBarButton {
    case cancel, completed
}

class TempReminderItem {
    var completed: Bool
    var text: String?
    var notifDate: Date?

    init() {
        self.completed = false
    }
}

enum DateRoundingType {
    case round
    case ceil
    case floor
}

extension Date {
    func format(date: Date) -> String {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        if(calendar.isDateInToday(date)) {
            dateFormatter.dateFormat = "HH:mm"
            return "Today, \(dateFormatter.string(from: date))"
        }
        if(calendar.component(.year, from: Date()) == calendar.component(.year, from: date)) {
            dateFormatter.dateFormat = "dd.MM. HH:mm"
        }
        return dateFormatter.string(from: date)
    }

    func rounded(minutes: TimeInterval, rounding: DateRoundingType = .round) -> Date {
        return rounded(seconds: minutes * 60, rounding: rounding)
    }
    func rounded(seconds: TimeInterval, rounding: DateRoundingType = .round) -> Date {
        var roundedInterval: TimeInterval = 0
        switch rounding {
        case .round:
            roundedInterval = (timeIntervalSinceReferenceDate / seconds).rounded() * seconds
        case .ceil:
            roundedInterval = ceil(timeIntervalSinceReferenceDate / seconds) * seconds
        case .floor:
            roundedInterval = floor(timeIntervalSinceReferenceDate / seconds) * seconds
        }
        return Date(timeIntervalSinceReferenceDate: roundedInterval)
    }
}

class NCTableViewController: UITableViewController, NewReminderTableCellProtocol, DatePickerTableCellProtocol, ReminderItemTableCellProtocol {

    @IBOutlet weak var rightBarButton: UIBarButtonItem!


    var items: [ReminderItem] = []

    private var hideDatePickerRow: Bool = true

    weak var delegateDP: DatePickerTableCellProtocol?
    weak var delegateNR: NewReminderTableCellProtocol?

    var tempReminderItem = TempReminderItem()
    var dataManager = DataManager()
    var rightBarButtonType: RightBarButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.sentRightBarButton(type: RightBarButton.completed)
        self.loadData()
    }

    func loadData() {
        self.items = self.dataManager.load(completed: false)
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setToDefault() {
        //not implemented
    }

    func datePickerChanged(date: Date) {
        self.delegateDP?.datePickerChanged(date: date)
        tempReminderItem.notifDate = date
    }

    func onOffNotifPrimaryActionTriggered(isNotifOn: Bool) {
        self.hideDatePickerRow = !isNotifOn
        print(isNotifOn)
        self.tempReminderItem.notifDate = !isNotifOn ? nil : self.tempReminderItem.notifDate
        tableView.beginUpdates()
        tableView.endUpdates()
    }

    func endInsertMode() {
        self.view.endEditing(true)
        self.sentRightBarButton(type: RightBarButton.completed)
        self.hideDatePickerRow = true
        self.delegateNR?.reminderTextPrimaryActionTriggered()
        tableView.beginUpdates()
        tableView.endUpdates()
    }

    func completedPrimaryActionTriggered(objectId: NSManagedObjectID, indexPath: IndexPath) {
        self.dataManager.setIsCompleted(completed: true, objectId: objectId)
        self.items.remove(at: indexPath.row - 2)
        let cell = tableView.cellForRow(at: indexPath) as! ReminderItemTableCell
        cell.completedButton.completed = true
        cell.completedButton.setNeedsDisplay()
        tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.right)
        tableView.reloadData()
    }


    func reminderTextPrimaryActionTriggered() {
        self.dataManager.save(temp: self.tempReminderItem)
        self.tempReminderItem = TempReminderItem()
        //end insert mode
        self.endInsertMode()
        self.loadData()
    }

    func reminderTextEditingChanged(text: String) {
        self.tempReminderItem.text = text
    }


    func reminderTextEditingDidBegin() {
        print("BEGIN")
        self.sentRightBarButton(type: RightBarButton.cancel)
        self.hideDatePickerRow = false
        tableView.beginUpdates()
        tableView.endUpdates()
    }

//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        if indexPath.row == 0 {
//            toggleShowDateDatepicker()
//        }
//
//
//        tableView.deselectRow(at: indexPath, animated: true)
//    }

    @IBAction func sentRightBarButtonAction(_ sender: Any) {
        if(self.rightBarButtonType == RightBarButton.cancel) {
            self.endInsertMode()
            //set to default state in NewReminderTableCell
            self.delegateDP?.setToDefault()
        } else {
            self.performSegue(withIdentifier: "toCompleted", sender: nil)
        }


    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if(indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "newReminderCell", for: indexPath) as! NewReminderTableCell
            cell.delegate = self
            if(!cell.cellAlreadyDidLoad) {
                cell.initCell(tableView: self)
            }
            return cell
        }
        if(indexPath.row == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "datePickerCell", for: indexPath) as! DatePickerTableCell
            cell.delegate = self
            if(!cell.cellAlreadyDidLoad) {
                cell.initCell(tableView: self)
            }
            return cell
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: "reminderItemCell", for: indexPath) as! ReminderItemTableCell
        let item = items[indexPath.row - 2]
        cell.label?.text = item.text
        if(item.notifDate == nil) {
            cell.dateLabel.isHidden = true
            let centerYCon = NSLayoutConstraint(item: cell.label,
                                                attribute: .centerY,
                                                relatedBy: .equal,
                                                toItem: cell,
                                                attribute: .centerY,
                                                multiplier: 1.0,
                                                constant: 0.0)
            NSLayoutConstraint.activate([centerYCon])
        } else {
            cell.dateLabel.text = Date().format(date: item.notifDate as! Date)
        }
        cell.indexPath = indexPath
        cell.objectId = item.objectID
        cell.completedButton.completed = item.completed
        cell.completedButton.setNeedsDisplay()
        cell.delegate = self
        return cell

    }

//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
//    {
//        print(indexPath)
//    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.hideDatePickerRow && indexPath.row == 1 {
            return 0
        }
            else if(!self.hideDatePickerRow && indexPath.row == 1) {
                return 218
        }

        return super.tableView(tableView, heightForRowAt: indexPath)

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count + 2
    }


    private func sentRightBarButton(type: RightBarButton) {
        self.rightBarButtonType = type
        if(type == RightBarButton.completed) {
            self.rightBarButton.title = nil
            self.rightBarButton.image = #imageLiteral(resourceName: "completed")
        } else {
            self.rightBarButton.image = nil
            self.rightBarButton.title = "Cancel"
        }
    }


}

