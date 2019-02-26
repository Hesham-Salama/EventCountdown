//
//  ViewController.swift
//  EventCountdown
//
//  Created by Hesham Salama on 2/23/19.
//  Copyright © 2019 hesham. All rights reserved.
//

import UIKit
import SwipeCellKit

protocol AddingEvents {
    func refreshTableView()
}

class MainViewController: UITableViewController {
    
    let CELL_ID = "event_cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareNavBar()
        prepareTableView()
    }
    
    @objc func addEvent(){
        navigateToPickEvent(index: nil)
    }
    
    func navigateToPickEvent(index: Int?) {
        let pickEventVC = PickEventViewController()
        pickEventVC.index = index
        pickEventVC.delegate = self
        navigationController?.pushViewController(pickEventVC, animated: true)
    }
    
    func refreshTableView() {
        self.tableView.reloadData()
    }
}

extension MainViewController: AddingEvents, SwipeTableViewCellDelegate {
    
    private func prepareNavBar() {
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addEvent))
        self.navigationItem.rightBarButtonItem = addBarButton
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Events"
    }
    
    func prepareTableView() {
        self.tableView.register(EventCell.classForCoder(), forCellReuseIdentifier: CELL_ID)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath) as! EventCell
        cell.eventLabel.text = EventManager.shared.events[indexPath.row].eventName
        cell.dateLabel.text = EventManager.shared.events[indexPath.row].eventTime.toString(withFormat:
            "EEEE, d MMMM yyyy h:mm a")
        cell.endTimeInSeconds = EventManager.shared.events[indexPath.row].eventTime.timeIntervalSince1970
        cell.delegate = self
        cell.configureCell()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToPickEvent(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            EventManager.shared.removeEventAt(index: indexPath.row)
            action.fulfill(with: .delete)
        }
        deleteAction.image = UIImage(named: "delete")
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EventManager.shared.events.count
    }
}

extension EventCell {
    
    private var getRemainingSeconds : TimeInterval {
        get {
            if let endTime = endTimeInSeconds {
                return endTime - Date().timeIntervalSince1970
            }
            return 0
        }
    }
    
    private func getRemainingTimeString(seconds: TimeInterval) -> String{
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        if let timeInterval = TimeInterval(exactly: seconds) {
            return formatter.string(from: timeInterval) ?? ""
        }
        return ""
    }
    
    func configureCell() {
        self.countDownLabel.text = getRemainingTimeString(seconds: getRemainingSeconds)
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
                [weak self] _ in
                guard let self = self else {return}
                if self.getRemainingSeconds <= 0 {
                    self.countDownLabel.textColor = UIColor.red
                    self.timer?.invalidate()
                    self.timer = nil
                } else {
                    self.countDownLabel.text = self.getRemainingTimeString(seconds: self.getRemainingSeconds)
                }
            }
        }
    }
    
    override func prepareForReuse() {
        self.timer?.invalidate()
        self.timer = nil
    }
}

extension Date {
    public mutating func floorSeconds() {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: self)
        self = calendar.date(from: components) ?? self
    }
    
    func toString(withFormat format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let myString = formatter.string(from: self)
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = format
        return formatter.string(from: yourDate!)
    }
}
