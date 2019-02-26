//
//  PickEventViewController.swift
//  EventCountdown
//
//  Created by Hesham Salama on 2/24/19.
//  Copyright © 2019 hesham. All rights reserved.
//

import UIKit

class PickEventViewController: UIViewController {

    var delegate : AddingEvents?
    var index: Int?
    var eventTextField : EventTextField!
    var datePicker : EventDatePicker!
    var confirmEventButton : ConfirmEventButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "Make an event"
        addDatePicker()
        addTextEdit()
        addButton()
        hideKeyboardWhenTappedAround()
    }
    
    func addDatePicker() {
        datePicker = EventDatePicker()
        if let index = index {
            datePicker.date = EventManager.shared.events[index].eventTime
        }
        self.view.addSubview(datePicker)
        addDatePickerConstraints()
    }
    
    
    func addTextEdit() {
        eventTextField = EventTextField()
        if let index = index {
            eventTextField.text = EventManager.shared.events[index].eventName
        }
        eventTextField.placeholder = "Event"
        self.view.addSubview(eventTextField)
        addTextFieldConstraints()
    }
    
    func addButton() {
        confirmEventButton = ConfirmEventButton()
        confirmEventButton.setTitle("Add Event", for: .normal)
        self.view.addSubview(confirmEventButton)
        confirmEventButton.addTarget(self, action: #selector(addEventButtonAction), for: .touchUpInside)
        addButtonConstraints()
    }
    
    @objc func addEventButtonAction(sender: UIButton!) {
        if let eventText = eventTextField.text, eventText.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
            var floorDate = datePicker.date
            floorDate.floorSeconds()
            if floorDate > Date().addingTimeInterval(60) {
                // logic
                let event = Event(eventName: eventText, eventTime: floorDate)
                if let index = index {
                    EventManager.shared.editEventAt(index: index, event: event)
                } else {
                    EventManager.shared.addEvent(event: event)
                }
                delegate?.refreshTableView()
                self.navigationController?.popViewController(animated: true)
            } else {
                displayAlert(text: "Date has already passed or is going to be very soon.")
            }
        } else {
            displayAlert(text: "Event field is empty.")
        }
    }
    
    private func displayAlert(text: String) {
        let alertDisapperTimeInSeconds = 2.0
        let alert = UIAlertController(title: nil, message: text, preferredStyle: .actionSheet)
        self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + alertDisapperTimeInSeconds) {
            alert.dismiss(animated: true)
        }
    }
    
}

extension PickEventViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    private func addTextFieldConstraints() {
        NSLayoutConstraint(item: eventTextField, attribute: .top, relatedBy: .equal, toItem: datePicker, attribute: .bottom, multiplier: 1.0, constant: 16).isActive = true
        NSLayoutConstraint(item: eventTextField, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 16).isActive = true
        NSLayoutConstraint(item: eventTextField, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: -16).isActive = true
        NSLayoutConstraint(item: eventTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50).isActive = true
    }
    
    private func addButtonConstraints() {
        NSLayoutConstraint(item: confirmEventButton, attribute: .top, relatedBy: .equal, toItem: eventTextField, attribute: .bottom, multiplier: 1.0, constant: 16).isActive = true
        NSLayoutConstraint(item: confirmEventButton, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 16).isActive = true
        NSLayoutConstraint(item: confirmEventButton, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: -16).isActive = true
        NSLayoutConstraint(item: confirmEventButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50).isActive = true
    }
    
    private func addDatePickerConstraints() {
        NSLayoutConstraint(item: datePicker, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 162).isActive = true
        NSLayoutConstraint(item: datePicker, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 16).isActive = true
        NSLayoutConstraint(item: datePicker, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: -16).isActive = true
        NSLayoutConstraint(item: datePicker, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 162).isActive = true
    }
}

extension EventDatePicker {
    func getTimeinDMYHMS() -> [Int] {
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        if let day = components.day, let hour = components.hour, let month = components.month,
            let year = components.year, let minute = components.minute, let second = components.second {
            return [day, month, year, hour, minute, second]
        }
        return []
    }
}
