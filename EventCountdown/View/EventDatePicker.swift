//
//  EventDatePicker.swift
//  EventCountdown
//
//  Created by Hesham Salama on 2/24/19.
//  Copyright © 2019 hesham. All rights reserved.
//

import UIKit

class EventDatePicker: UIDatePicker {

    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        minimumDate = Date().addingTimeInterval(60)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
