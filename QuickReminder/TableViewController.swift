//
//  ViewController.swift
//  QuickReminder
//
//  Created by Michael on 7/9/17.
//  Copyright © 2017 Michal Vranec. All rights reserved.
//

import UIKit


class TableViewController: UITableViewController,NewReminderTableCellProtocol,DatePickerTableCellProtocol {
    
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    
    private var items = ReminderItem.getMockData()
    private var hideDatePickerRow:Bool = true;
    
    weak var delegateDP:DatePickerTableCellProtocol?
    weak var delegateNR: NewReminderTableCellProtocol?
    
    var newReminderItem: ReminderItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideAddBarButton(hide: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func datePickerChanged(date: Date) {
        self.delegateDP?.datePickerChanged(date: date)
    }
    
    func onOffNotifPrimaryActionTriggered(isNotifOn: Bool) {
        self.hideDatePickerRow = isNotifOn
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func reminderTextPrimaryActionTriggered() {
        self.view.endEditing(true);
        self.hideAddBarButton(hide: true)
        self.hideDatePickerRow = true
        self.delegateNR?.reminderTextPrimaryActionTriggered()
        tableView.beginUpdates()
        tableView.endUpdates()

    }

    func reminderTextEditingChanged(hasText:Bool) {
         self.addBarButton.isEnabled = hasText
    }
    
    func reminderTextEditingDidBegin() {
        self.hideAddBarButton(hide: false)
        //set only not clickable
        self.addBarButton.isEnabled = false
        self.hideDatePickerRow = false
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
//    @IBAction func addReminderAction(_ sender: Any) {
//        self.endEditMode()
//        print("Add")
//    }
//

    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        if indexPath.row == 0 {
//            toggleShowDateDatepicker()
//        }
//
//
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
    
    @IBAction func addReminderItem(_ sender: Any) {
        print(self.newReminderItem)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
    
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "newReminderCell", for: indexPath) as! NewReminderTableCell
            cell.delegate = self
            if(!cell.cellAlreadyDidLoad){
                cell.initCell(tableView:self)
            }
            return cell
        }

        if(indexPath.row == 1){
            let cell = tableView.dequeueReusableCell(withIdentifier: "datePickerCell", for: indexPath) as! DatePickerTableCell
            cell.delegate = self
            if(!cell.cellAlreadyDidLoad){
                cell.initCell(tableView:self)
            }
            return cell
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: "reminderCellItem", for: indexPath)
        
            let item = items[indexPath.row - 2]
            cell.textLabel?.text = item.text
        
        return cell
        
    }
    
    
    override func tableView(_ tableView:UITableView,heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.hideDatePickerRow && indexPath.row == 1 {
            return 0
        }
        else if(!self.hideDatePickerRow && indexPath.row == 1){
            return 218
        }
        
        return super.tableView(tableView, heightForRowAt: indexPath)
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return items.count + 2
    }
    
    private func hideAddBarButton(hide:Bool){
        if(hide){
            self.addBarButton.isEnabled = false;
            self.addBarButton.tintColor = UIColor.clear
        }else{
            self.addBarButton.isEnabled = true;
            self.addBarButton.tintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        }
    }


}

