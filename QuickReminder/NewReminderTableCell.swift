//
//  NewReminderTableCell.swift
//  QuickReminder
//
//  Created by Michal Vranec on 16/07/2017.
//  Copyright © 2017 Michal Vranec. All rights reserved.
//

import Foundation
import FontAwesome_swift

protocol NewReminderTableCellProtocol:class {
    func reminderTextEditingDidBegin()
    func reminderTextPrimaryActionTriggered()
    func onOffNotifPrimaryActionTriggered(isNotifOn:Bool)
    func reminderTextEditingChanged(text:String)
}

class NewReminderTableCell : UITableViewCell,DatePickerTableCellProtocol{
    
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var onOfNotifButtonView: UIView!
    @IBOutlet weak var onOffNotifButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var reminderTextInput: UITextField!
    
    weak var delegate:NewReminderTableCellProtocol?
    
    var cellAlreadyDidLoad:Bool = false
    
    private var isNotifOn: Bool = true
    
    public func initCell(tableView:NCTableViewController){
        tableView.delegateDP = self
        self.stackView.widthAnchor.constraint(equalToConstant: self.bounds.width - 96 ).isActive = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleOnOfButtonViewTap))
        self.onOfNotifButtonView.addGestureRecognizer(tapGesture)
        self.reminderTextInput.returnKeyType = .done
        self.onOffNotifButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 20)
        self.onOffNotifButton.setTitle(String.fontAwesomeIcon(name: .bell), for: .normal)
        self.cellAlreadyDidLoad = true;
    }
    
    
    func handleOnOfButtonViewTap(){
        self.toggleOnOffNotif()
    }
    
    func setToDefault(){
        endInsertMode()
    }
    
    func datePickerChanged(date: Date) {
        self.setDateLabel(date: date)
    }
    
    func setDateLabel(date:Date){
        let currentDate = Date()
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        if(calendar.isDateInToday(date)){
            dateFormatter.dateFormat = "HH:mm"
            self.dateLabel.text = "Today \(dateFormatter.string(from: date))"
        }else {
            if(calendar.component(.year, from: currentDate) == calendar.component(.year, from: date)){
                dateFormatter.dateFormat = "dd.MM. HH:mm"
            }
            self.dateLabel.text  = dateFormatter.string(from: date)
        }
    }
    

    @IBAction func reminderTextEditingChanged(_ sender: Any) {
        self.delegate?.reminderTextEditingChanged(text: self.reminderTextInput.text!)
    }
    
    @IBAction func reminderTextEditingDidBegin(_ sender: Any) {
        self.delegate?.reminderTextEditingDidBegin()
        self.dateLabel.isHidden = false
        self.onOffNotifButton.isHidden = false;
    }
    
    private func endInsertMode(){
        self.reminderTextInput.text = ""
        self.dateLabel.isHidden = true
        self.onOffNotifButton.isHidden = true
        // reset icon to ON state
        self.onOffNotifButton.setTitle(String.fontAwesomeIcon(name: .bell), for: .normal)
        let currentDate = Date()
        self.setDateLabel(date: currentDate)
    }
    
    @IBAction func reminderTextPrimaryActionTriggered(_ sender: Any) {
        if(self.reminderTextInput.hasText){
         delegate?.reminderTextPrimaryActionTriggered()
         self.endInsertMode()
        }
    }
    
    
    func toggleOnOffNotif(){
        if(self.isNotifOn){
            //set to off
            self.dateLabel.isHidden = true;
            self.onOffNotifButton.setTitle(String.fontAwesomeIcon(name: .bellO), for: .normal)
        }else{
            //set to on
            self.dateLabel.isHidden = false;
            self.onOffNotifButton.setTitle(String.fontAwesomeIcon(name: .bell), for: .normal)
        }
        delegate?.onOffNotifPrimaryActionTriggered(isNotifOn: isNotifOn)
        self.isNotifOn  = !isNotifOn

    }
    
    @IBAction func onOffNotifPrimaryActionTriggered(_ sender: Any) {
            self.toggleOnOffNotif()
    }
    
    
}
