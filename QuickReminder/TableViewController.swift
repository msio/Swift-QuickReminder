//
//  ViewController.swift
//  QuickReminder
//
//  Created by Michael on 7/9/17.
//  Copyright © 2017 Michal Vranec. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    @IBAction func datePickerVisible() {
    }
    
    @IBOutlet weak var datePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.hideAddBarButton(hide: true)
        self.datePicker.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addReminderAction(_ sender: Any) {
        self.view.endEditing(true);
        self.datePicker.isHidden = true
        print("Cancel")
    }

    @IBAction func reminderTextPrimaryActionTriggered(_ sender: Any) {
        self.view.endEditing(true);
        self.datePicker.isHidden = true
        tableView.beginUpdates()
        tableView.endUpdates()
    }

    @IBAction func reminderTextEditingDidBegin(_ sender: Any) {
        self.hideAddBarButton(hide: false)
        self.datePicker.isHidden = false
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
    
    
    
    override func tableView(_ tableView:UITableView,heightForRowAt indexPath: IndexPath) -> CGFloat {
        print(self.datePicker.isHidden)
        if self.datePicker.isHidden && indexPath.row == 1 {
            return 0
        }
        else {
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    private func hideAddBarButton(hide:Bool){
        if(hide){
//            self.addBarButton.isEnabled = false;
//            self.addBarButton.tintColor = UIColor.clear
        }else{
//            self.addBarButton.isEnabled = true;
//            self.addBarButton.tintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        }
    }


}

