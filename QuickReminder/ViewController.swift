//
//  ViewController.swift
//  QuickReminder
//
//  Created by Michael on 7/9/17.
//  Copyright © 2017 Michal Vranec. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var reminderText: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       self.reminderText.returnKeyType = UIReturnKeyType.done
        self.datePicker.isHidden = true
            self.hideCancelBarButton(hide: true)
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
    }
    @IBAction func reminderTextEditingDidBegin(_ sender: Any) {
        self.hideCancelBarButton(hide: false)
    }
    
    func hideCancelBarButton(hide:Bool){
        if(hide){
            self.addButton.isEnabled = false;
            self.addButton.tintColor = UIColor.clear
        }else{
            self.addButton.isEnabled = true;
            self.addButton.tintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        }
    }
}

