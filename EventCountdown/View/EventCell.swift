//
//  EventCell.swift
//  EventCountdown
//
//  Created by Hesham Salama on 2/23/19.
//  Copyright © 2019 hesham. All rights reserved.
//

import UIKit
import SwipeCellKit

//class EventCell: UITableViewCell {
class EventCell: SwipeTableViewCell {


    var timer: Timer?
    var endTimeInSeconds: TimeInterval?
    
    var eventLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    var dateLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.blue
        return label
    }()
    
    var countDownLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(red: 0.1412, green: 0.5765, blue: 0, alpha: 1.0)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(eventLabel)
        self.addSubview(dateLabel)
        self.addSubview(countDownLabel)
        addConstraints()
    }
    
    private func addConstraints() {
        NSLayoutConstraint(item: eventLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 8).isActive = true
        NSLayoutConstraint(item: eventLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 20).isActive = true
        NSLayoutConstraint(item: eventLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -20).isActive = true
        
        NSLayoutConstraint(item: dateLabel, attribute: .top, relatedBy: .equal, toItem: eventLabel, attribute: .bottom, multiplier: 1.0, constant: 8).isActive = true
        NSLayoutConstraint(item: dateLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 20).isActive = true
        NSLayoutConstraint(item: dateLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -20).isActive = true
       
        NSLayoutConstraint(item: countDownLabel, attribute: .top, relatedBy: .equal, toItem: dateLabel, attribute: .bottom, multiplier: 1.0, constant: 8).isActive = true
        NSLayoutConstraint(item: countDownLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 20).isActive = true
        NSLayoutConstraint(item: countDownLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -20).isActive = true
        NSLayoutConstraint(item: countDownLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -8).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
