//
//  ViewController.swift
//  Dental-App
//
//  Created by Cristian Duguet on 6/15/15.
//  Copyright (c) 2015 Dental-App. All rights reserved.
//

import UIKit
import Parse
import MediaPlayer


class ViewController: UIViewController, UIActionSheetDelegate {

    //Movie Player variables
    var movieViewController : MPMoviePlayerViewController?
    var movieplayer : MPMoviePlayerController!
    
    //Buttons
    @IBOutlet var brushButton: UIButton!
    @IBOutlet var flossButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Image in Title above NAvigation Bar
        let titleImage : UIImage = UIImage(named: "logo_blue")!
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .ScaleAspectFit
        imageView.image = titleImage
        self.navigationItem.titleView = imageView

        
        //Video Player setup
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "doneButtonClick:", name: MPMoviePlayerPlaybackDidFinishNotification, object: nil)
        
        //Video Button Styles
        brushButton.layer.cornerRadius = BUTTONS_CORNER_RADIUS;
        flossButton.layer.cornerRadius = BUTTONS_CORNER_RADIUS;
    }
    
    @IBAction func infoVideoClicked(sender: AnyObject) {
        let path = NSBundle.mainBundle().pathForResource("video1", ofType:"mp4")
        let url = NSURL.fileURLWithPath(path!)
        movieViewController = MPMoviePlayerViewController(contentURL: url)
        self.presentMoviePlayerViewControllerAnimated(movieViewController)
        movieViewController?.moviePlayer.play()
    }
    
    
    @IBAction func brushButtonClicked(sender: AnyObject) {
        //self.performSegueWithIdentifier("playerSegue", sender: self)
        let path = NSBundle.mainBundle().pathForResource("video1", ofType:"mp4")
        print(path)
        let url = NSURL.fileURLWithPath(path!)
        movieViewController = MPMoviePlayerViewController(contentURL: url)
        self.presentMoviePlayerViewControllerAnimated(movieViewController)
        movieViewController?.moviePlayer.play()
    }
    
    @IBAction func flossButtonClicked(sender: AnyObject) {
        let path = NSBundle.mainBundle().pathForResource("video2", ofType:"mp4")
        let url = NSURL.fileURLWithPath(path!)
        movieViewController = MPMoviePlayerViewController(contentURL: url)
        self.presentMoviePlayerViewControllerAnimated(movieViewController)
        movieViewController?.moviePlayer.play()

    }
    
    
    func doneButtonClick(sender:NSNotification?){
        let value = UIInterfaceOrientation.Portrait.rawValue
        UIDevice.currentDevice().setValue(value, forKey: "orientation")
        movieViewController?.moviePlayer.stop()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if PFUser.currentUser() != nil {
        } else {
            Utilities.loginUser(self)
        }
    }




}
    // ------------------------------- LOGGING OUT FUNCTIONS
    
    
    /*
    @IBAction func logOutPressed(sender: AnyObject) {
        self.logout()
    }

*/

    /*
    
    func logout() {
        var actionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Log out")
        actionSheet.showFromTabBar(self.tabBarController?.tabBar)
    }
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex != actionSheet.cancelButtonIndex {
            PFUser.logOut()
            PushNotication.parsePushUserResign()
            Utilities.postNotification(NOTIFICATION_USER_LOGGED_OUT)
            self.cleanup()
            Utilities.loginUser(self)
        }
    }
    func cleanup() {
    }
    

}*/

