//
//  Alarm.swift
//  Dental-App
//
//  Created by Cristian Duguet on 7/10/15.
//  Copyright (c) 2015 Dental-App. All rights reserved.
//

import Foundation

struct AlarmItem {
    var title: String
    var time: NSDate
    var UUID: String
    
    var isOverdue: Bool {
        return (NSDate().compare(self.time) == NSComparisonResult.OrderedDescending) // time is earlier than current date
    }
    
    init(time: NSDate, title: String, UUID: String) {
        self.time = time
        self.title = title
        self.UUID = UUID
    }
}