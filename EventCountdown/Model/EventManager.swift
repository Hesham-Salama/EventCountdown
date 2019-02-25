//
//  Events.swift
//  EventCountdown
//
//  Created by Hesham Salama on 2/24/19.
//  Copyright © 2019 hesham. All rights reserved.
//

import Foundation

struct EventManager {

    private let EVENT_USER_DEFAULT_KEY = "event_key"
    var events: [Event] = [Event]()
    static var shared = EventManager()

    
    private init() {
        getEventsByUserDefault()
    }
    
    private mutating func getEventsByUserDefault() {
        if let decoded  = UserDefaults.standard.object(forKey: EVENT_USER_DEFAULT_KEY) as? Data,
            let arr = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded) as! [Event] {
           events = arr
        }
    }
    
    mutating func addEvent(event: Event) {
        events.append(event)
        let eventsTemp = events.sorted(by: { $0.eventTime < $1.eventTime })
        setEvents(events: eventsTemp)
    }

    private mutating func setEvents(events: [Event]) {
        if let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: events, requiringSecureCoding: false) {
            UserDefaults.standard.set(encodedData, forKey: EVENT_USER_DEFAULT_KEY)
        } else {
            fatalError("Saving Failed!!!")
        }
        self.events = events
    }
}
