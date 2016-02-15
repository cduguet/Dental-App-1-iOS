//
//  AlarmTableViewController.swift
//  Dental-App
//
//  Created by Cristian Duguet on 7/10/15.
//  Copyright (c) 2015 Dental-App. All rights reserved.
//

import UIKit

class AlarmTableViewController: UITableViewController {
    var alarmItems: [AlarmItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshList", name: "AlarmListShouldRefresh", object: nil)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        refreshList()
    }
    
    func refreshList() {
        alarmItems = AlarmList.sharedInstance.allItems()
        
        if (alarmItems.count >= 64) {
            self.navigationItem.rightBarButtonItem!.enabled = false // disable 'add' button
        } else if alarmItems.count == 0 {
            
            let alertController = UIAlertController(title: NSLocalizedString("\n \n \n Start a good habit", comment: "No Alarms Dialog title"), message:
                NSLocalizedString("Schedule at which time do you brush your teeth and we will remind you to do it, and improve your dental health!", comment: "Alert Dialog string"), preferredStyle: UIAlertControllerStyle.Alert)
            
            var logoAlert = UIImageView(frame: CGRectMake(105, 15, 60, 60))
            logoAlert.image = UIImage(named: "clock_blue")
            
            alertController.view.addSubview(logoAlert)
            
            
            alertController.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "To Cancel in Alert Dialog"), style: UIAlertActionStyle.Default,handler: nil))
            
            alertController.addAction(UIAlertAction(title: NSLocalizedString("Go Schedule!", comment: "Dialog to schedule an alarm"), style: .Default, handler: { action in
                switch action.style{
                case .Default:
                    self.performSegueWithIdentifier("editAlarmSegue", sender: nil)
                case .Cancel:
                    print("cancel")
                    
                case .Destructive:
                    print("destructive")
                }
            }))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        tableView.reloadData()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return alarmItems.count
    }

    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true // all cells are editable
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete { // the only editing style we'll support
            // delete the row from the data source
            var item = alarmItems.removeAtIndex(indexPath.row) // remove AlarmItem from notifications array, assign removed item to 'item'
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            AlarmList.sharedInstance.removeItem(item) // delete backing property list entry and unschedule local notification (if it still exists)
            self.navigationItem.rightBarButtonItem!.enabled = true // we definitely have under 64 notifications scheduled now, make sure 'add' button is enabled
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("alarmCell", forIndexPath: indexPath) as! UITableViewCell // retrieve the prototype cell (subtitle style)
        let alarmItem = alarmItems[indexPath.row] as AlarmItem
        cell.textLabel?.text = NSLocalizedString("Alarm ", comment: "alarm displayed in alarm list") + "\(indexPath.row + 1)"
        
        /*
        if (alarmItem.isOverdue) { // the current time is later than the to-do item's deadline
            cell.detailTextLabel?.textColor = UIColor.redColor()
        } else {
            cell.detailTextLabel?.textColor = UIColor.blackColor() // we need to reset this because a cell with red subtitle may be returned by dequeueReusableCellWithIdentifier:indexPath:
        }
        */
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = NSLocalizedString("'Every day at' h:mm a", comment: "time displayed in an alarm") // example: "Every day at 12:00 PM"
        cell.detailTextLabel?.text = dateFormatter.stringFromDate(alarmItem.time)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let alarmItem = alarmItems[indexPath.row] as AlarmItem
        self.performSegueWithIdentifier("editAlarmSegue", sender: alarmItem.UUID as AnyObject)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "editAlarmSegue" {
            let alarmVC = segue.destinationViewController as! AlarmSchedulingViewController
            alarmVC.hidesBottomBarWhenPushed = true
            if let id = sender as? String {
            alarmVC.alarmID = id as String
            }
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
