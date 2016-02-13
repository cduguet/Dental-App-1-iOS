//
//  WelcomeViewController.swift
//  Dental-App
//
//  Created by Cristian Duguet on 7/8/15.
//  Copyright (c) 2015 Dental-App. All rights reserved.
//

import UIKit
import Parse

class WelcomeViewController: UIViewController {

    
    @IBOutlet var fbButton: UIButton!
    @IBOutlet var emailButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // navigation bar style
        let bar:UINavigationBar! =  self.navigationController?.navigationBar
        bar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        bar.shadowImage = UIImage()

        
        // button Styles
        fbButton.layer.cornerRadius = BUTTONS_CORNER_RADIUS;
        emailButton.layer.cornerRadius = BUTTONS_CORNER_RADIUS;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func facebookLogin(sender: UIButton) {
        ProgressHUD.show(NSLocalizedString("Signing in...", comment: "Signing in facebook"), interaction: false)
        PFFacebookUtils.logInInBackgroundWithReadPermissions(PF_USER_PERMISSIONS) {
            (user: PFUser?, error: NSError?) -> Void in
            if let user = user {
                if user.isNew {
                    self.userLoggedIn(user)
                    println("User signed up and logged in through Facebook!")
                } else {
                    self.userLoggedIn(user)
                    println("User logged in through Facebook!")
                }
            } else {
                ProgressHUD.showError(NSLocalizedString("Facebook sign in error", comment: "Error logging in facebook"))
                println("Uh oh. The user cancelled the Facebook login.")
            }
        }
        
    }
        
    func userLoggedIn(user: PFUser) {
        PushNotication.parsePushUserAssign()
        ProgressHUD.showSuccess(NSLocalizedString("Welcome", comment: "Welcome at login"))
        self.dismissViewControllerAnimated(true, completion: nil)
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
