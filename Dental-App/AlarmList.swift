//
//  AlarmList.swift
//  Dental-App
//
//  Created by Cristian Duguet on 7/10/15.
//  Copyright (c) 2015 Dental-App. All rights reserved.
//

import Foundation


class AlarmList {
    class var sharedInstance : AlarmList {
        struct Static {
            static let instance : AlarmList = AlarmList()
        }
        return Static.instance
    }
    private let ITEMS_KEY = "alarmItems"
    
    
    func allItems() -> [AlarmItem] {
        let alarmDictionary = NSUserDefaults.standardUserDefaults().dictionaryForKey(ITEMS_KEY) ?? [:]
        let items = Array(alarmDictionary.values)
        return items.map(
            {AlarmItem(time: $0["time"] as! NSDate,
                title: $0["title"] as! String,
                UUID: $0["UUID"] as! String!)
        }).sort() {(left: AlarmItem, right:AlarmItem) -> Bool in
            (left.time.compare(right.time) == .OrderedAscending)
        }
    }
    
    
    func addItem(item: AlarmItem) { // persist a representation of this alarm item in NSUserDefaults
        var alarmDictionary = NSUserDefaults.standardUserDefaults().dictionaryForKey(ITEMS_KEY) ?? Dictionary() // if AlarmItems hasn't been set in user defaults, initialize alarmDictionary to an empty dictionary using nil-coalescing operator (??)
        
        alarmDictionary[item.UUID] = ["time": item.time, "title": item.title, "UUID": item.UUID] // store NSData representation of alarm item in dictionary with UUID as key
        NSUserDefaults.standardUserDefaults().setObject(alarmDictionary, forKey: ITEMS_KEY) // save/overwrite alarm item list
        // create a corresponding local notification
        let notification = UILocalNotification()
        notification.alertBody = NSLocalizedString("Time to brush your teeth!", comment: "Alert Notification") // text that will be displayed in the notification
        notification.alertAction = "open" // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
        notification.fireDate = item.time // alarm item time (when notification will be fired)
        notification.soundName = UILocalNotificationDefaultSoundName // play default sound
        notification.userInfo = ["UUID": item.UUID, ] // assign a unique identifier to the notification so that we can retrieve it later
        notification.category = "HEALTH_CATEGORY"
        notification.repeatInterval = NSCalendarUnit.Day // Repeat every day
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    func removeItem(item: AlarmItem) {
        for notification in UIApplication.sharedApplication().scheduledLocalNotifications! as [UILocalNotification] { // loop through notifications...
            if (notification.userInfo!["UUID"] as! String == item.UUID) { // ...and cancel the notification that corresponds to this AlarmItem instance (matched by UUID)
                UIApplication.sharedApplication().cancelLocalNotification(notification) // there should be a maximum of one match on UUID
                break
            }
        }
        
        if var alarmItems = NSUserDefaults.standardUserDefaults().dictionaryForKey(ITEMS_KEY) {
            alarmItems.removeValueForKey(item.UUID)
            NSUserDefaults.standardUserDefaults().setObject(alarmItems, forKey: ITEMS_KEY) // save/overwrite alarm item list
        }
    }
    
    func fetchTimeByUDID(UDID: String) -> NSDate? {
        print(UDID)
        var alarmDictionary = NSUserDefaults.standardUserDefaults().dictionaryForKey(ITEMS_KEY) ?? [:]
        print(alarmDictionary)
        if let element = alarmDictionary[UDID] as? Dictionary<String, AnyObject> {
            var t = element["time"] as! NSDate
            return t
        }
        return nil
    }
}



