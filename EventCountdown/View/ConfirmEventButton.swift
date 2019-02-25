//
//  ConfirmEventButton.swift
//  EventCountdown
//
//  Created by Hesham Salama on 2/24/19.
//  Copyright © 2019 hesham. All rights reserved.
//

import UIKit

class ConfirmEventButton: UIButton {

    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        self.setTitleColor(.white, for: .normal)
        self.backgroundColor = .blue
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
