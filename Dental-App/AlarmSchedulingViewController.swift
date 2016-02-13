//
//  AlarmSchedulingViewController.swift
//  Dental-App
//
//  Created by Cristian Duguet on 7/10/15.
//  Copyright (c) 2015 Dental-App. All rights reserved.
//

import UIKit

class AlarmSchedulingViewController: UIViewController {
    
    var alarmID : String = ""
    @IBOutlet var timePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let alarmTime = AlarmList.sharedInstance.fetchTimeByUDID(alarmID)
        if (alarmTime != nil) {
            timePicker.date = alarmTime!
        }
        // If there was an alarm: load
    }
    
    @IBAction func addPressed(sender: AnyObject) {
        let alarmItem = AlarmItem(time: timePicker.date, title: "Alarm", UUID: NSUUID().UUIDString)
        AlarmList.sharedInstance.addItem(alarmItem) // schedule a local notification to persist this item
        
        var prev_alarm: AlarmItem =  AlarmItem(time: NSDate.new(), title: "Alarm", UUID: alarmID)
        AlarmList.sharedInstance.removeItem(prev_alarm)
        self.navigationController?.popToRootViewControllerAnimated(true) // return to list view
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
