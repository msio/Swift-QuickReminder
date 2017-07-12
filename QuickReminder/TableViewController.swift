//
//  ViewController.swift
//  QuickReminder
//
//  Created by Michael on 7/9/17.
//  Copyright © 2017 Michal Vranec. All rights reserved.
//

import UIKit
import FontAwesome_swift

class TableViewController: UITableViewController {
    
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var inputText: UITextField!
    @IBOutlet weak var inputDate: UILabel!
    @IBOutlet weak var onOffNotifButton: UIButton!
    
    private var isNotifOn: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideAddBarButton(hide: true)
        self.datePicker.isHidden = true
        self.onOffNotifButton.isHidden = true;
        self.onOffNotifButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 20)
        self.onOffNotifButton.setTitle(String.fontAwesomeIcon(name: .bell), for: .normal)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addReminderAction(_ sender: Any) {
        self.endEditMode()
        print("Add")
    }

    @IBAction func reminderTextPrimaryActionTriggered(_ sender: Any) {
        self.endEditMode()
    }
    
    @IBAction func onOffNotifPrimaryActionTriggered(_ sender: Any) {
        if(self.isNotifOn){
            //set to off
            self.datePicker.isHidden = true
            self.onOffNotifButton.setTitle(String.fontAwesomeIcon(name: .bellO), for: .normal)
        }else{
            //set to on
            self.datePicker.isHidden = false
            self.onOffNotifButton.setTitle(String.fontAwesomeIcon(name: .bell), for: .normal)
        }
        self.isNotifOn  = !isNotifOn
        tableView.beginUpdates()
        tableView.endUpdates()
    }

    private func endEditMode(){
        self.view.endEditing(true);
        self.datePicker.isHidden = true
        self.hideAddBarButton(hide: true)
        tableView.beginUpdates()
        tableView.endUpdates()
        self.inputText.text = ""
    }
    
    @IBAction func reminderTextEditingDidBegin(_ sender: Any) {
        self.hideAddBarButton(hide: false)
        self.onOffNotifButton.isHidden = false;
        updateDate()
        self.datePicker.isHidden = false
        tableView.beginUpdates()
        tableView.endUpdates()

    }
    
    @IBAction func reminderTextEditingDidEnd(_ sender: Any) {
        self.onOffNotifButton.isHidden = true;
    }
    
    private func updateDate(){
        let currentDate = Date()
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        if(calendar.isDateInToday(self.datePicker.date)){
            dateFormatter.dateFormat = "HH:mm"
            self.inputDate.text = "Today \(dateFormatter.string(from: self.datePicker.date))"
        }else {
            if(calendar.component(.year, from: currentDate) == calendar.component(.year, from: self.datePicker.date)){
                dateFormatter.dateFormat = "dd.MM. HH:mm"
            }
            self.inputDate.text  = dateFormatter.string(from: self.datePicker.date)
        }
 
    }
    
    @IBAction func datePickerChanged(_ sender: Any) {
        self.updateDate()
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
    
    
    
    override func tableView(_ tableView:UITableView,heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.datePicker.isHidden && indexPath.row == 1 {
            return 0
        }
        else {
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
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

