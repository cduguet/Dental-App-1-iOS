//
//  LoginViewController.swift
//  Dental-App
//
//  Created by Cristian Duguet on 7/8/15.
//  Copyright (c) 2015 Dental-App. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController, UITextFieldDelegate  {

    @IBOutlet var usernameField: UITextField!
    
    @IBOutlet var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "dismissKeyboard"))
        self.usernameField.delegate = self
        loginButton.layer.cornerRadius = BUTTONS_CORNER_RADIUS;
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.usernameField.becomeFirstResponder()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.usernameField {
            self.register()
        }
        return true
    }
    
    
    @IBAction func loginButtonPressed(sender: AnyObject) {
        self.register()
    }
    
    
    func register() {
        let username = usernameField.text.lowercaseString
        
        if count(username) == 0 {
            ProgressHUD.showError(NSLocalizedString("Email field is empty.", comment: "empty field at loginscreen"))
            return
        }
        
        ProgressHUD.show(NSLocalizedString("Please wait...", comment: "please wait!"), interaction: false)
        
        PFAnonymousUtils.logInWithBlock {
            (user: PFUser?, error: NSError?) -> Void in
            if error != nil || user == nil {
                println("Anonymous login failed.")
                if let userInfo = error!.userInfo {
                    ProgressHUD.showError(userInfo["error"] as! String)
                }
            } else {
                println("Anonymous user logged in.")
                println("Saving email information")
                var user = PFUser.currentUser()
               //user?[PF_USER_USERNAME] = username
                user?[PF_USER_CONTACTEMAIL] = username
                user!.saveInBackgroundWithBlock({ (succeeded, error) -> Void in
                    if error == nil {
                        ProgressHUD.showSuccess(NSLocalizedString("Welcome", comment: "Welcome at login"))
                        self.dismissViewControllerAnimated(true, completion: nil)
                    } else {
                        PFUser.logOut()
                        if let info = error!.userInfo {
                            ProgressHUD.showError("Login error")
                            println(error!.code)
                            println(info["error"] as! String)
                        }
                    }
                })

            }
        }
        
        
        /*user.signUpInBackgroundWithBlock { (succeeded, error) -> Void in
            if error == nil {
                user[PF_USER_ACTIVATED] = true
                PushNotication.parsePushUserAssign()
                ProgressHUD.showSuccess("Welcome!")
                self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                if let userInfo = error!.userInfo {
                    ProgressHUD.showError(userInfo["error"] as! String)
                }
            }
        }*/
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
