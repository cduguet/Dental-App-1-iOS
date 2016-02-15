//
//  MoreTableViewController.swift
//  Dental-App
//
//  Created by Cristian Duguet on 7/28/15.
//  Copyright (c) 2015 Dental-App. All rights reserved.
//

import UIKit
import Parse
import MediaPlayer


class MoreTableViewController: UITableViewController, UIActionSheetDelegate{
    
    //Movie Player variables
    var movieViewController : MPMoviePlayerViewController?
    var movieplayer : MPMoviePlayerController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Video Player setup
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "doneButtonClick:", name: MPMoviePlayerPlaybackDidFinishNotification, object: nil)
      
            
        let path = NSBundle.mainBundle().pathForResource("video1", ofType:"mp4")
        let url = NSURL.fileURLWithPath(path!)
        
        //var url = NSURL(string: "http://jplayer.org/video/m4v/Big_Buck_Bunny_Trailer.m4v")!
        movieViewController = MPMoviePlayerViewController(contentURL: url)


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return 3
    }
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .None
    }
    
    override func tableView(tableView: UITableView, shouldIndentWhileEditingRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            //self.performSegueWithIdentifier("playerSegue", sender: self)
            self.presentMoviePlayerViewControllerAnimated(movieViewController)
            movieViewController?.moviePlayer.play()
            
        case 2:
            self.logout()
        
        default:
            self.cleanup()
            
        }
    }
    
    
    func doneButtonClick(sender:NSNotification?){
        let value = UIInterfaceOrientation.Portrait.rawValue
        UIDevice.currentDevice().setValue(value, forKey: "orientation")
        movieViewController?.moviePlayer.stop()
    }

    
    func logout() {
//        var actionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: NSLocalizedString("Cancel", comment: "To Cancel") , destructiveButtonTitle: nil, otherButtonTitles: NSLocalizedString("Log Out", comment: "To Log Out"))
//      actionSheet.showFromTabBar((self.tabBarController?.tabBar)!);
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet);
        actionSheet.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "To Cancel"), style: UIAlertActionStyle.Cancel, handler:nil));
        actionSheet.addAction(UIAlertAction(title: NSLocalizedString("Log Out", comment: "To Log Out"), style: UIAlertActionStyle.Destructive, handler:{ action in self.loggedOut()}));
    }
    
    func loggedOut() {
        PFUser.logOut()
        PushNotication.parsePushUserResign()
        Utilities.postNotification(NOTIFICATION_USER_LOGGED_OUT)
        self.cleanup()
        Utilities.loginUser(self)
    };
//    Deprecated from iOS 7 Swift 1
//    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
//        if buttonIndex != actionSheet.cancelButtonIndex {
//            PFUser.logOut()
//            PushNotication.parsePushUserResign()
//            Utilities.postNotification(NOTIFICATION_USER_LOGGED_OUT)
//            self.cleanup()
//            Utilities.loginUser(self)
//        }
//    }
    func cleanup() {
    }
    

    

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
