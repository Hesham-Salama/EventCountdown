//
//  Event.swift
//  EventCountdown
//
//  Created by Hesham Salama on 2/25/19.
//  Copyright © 2019 hesham. All rights reserved.
//

import Foundation

class Event: NSObject, NSCoding {
    
    private static let CODER_EVENT_NAME_KEY = "event_name"
    private static let CODER_EVENT_TIME_KEY = "event_time"

    var eventName: String
    var eventTime : Date
    
    init(eventName: String, eventTime: Date) {
        self.eventName = eventName
        self.eventTime = eventTime
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let eventName = aDecoder.decodeObject(forKey: Event.CODER_EVENT_NAME_KEY) as! String
        let eventTime = aDecoder.decodeObject(forKey: Event.CODER_EVENT_TIME_KEY) as! Date
        self.init(eventName: eventName, eventTime: eventTime)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(eventName, forKey: Event.CODER_EVENT_NAME_KEY)
        aCoder.encode(eventTime, forKey: Event.CODER_EVENT_TIME_KEY)
    }
}
