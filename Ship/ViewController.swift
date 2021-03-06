//
//  ViewController.swift
//  Ship
//
//  Created by Andrew Page on 5/15/15.
//  Copyright (c) 2015 Ship. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    #if DEBUG
    let debugMode = true
    #else
    let debugMode = false
    #endif

    @IBOutlet weak var sEmailField: UITextField!
    @IBOutlet weak var sPasswordField: UITextField!
    @IBOutlet weak var sErrorLabel: UILabel!
    @IBOutlet weak var sDebugModeLabel: UILabel!

    var apiManager: SAPIManager!
    var jobs: [SJob]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearError()
        
        apiManager = SAPIManager()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "dismissKeyboard"))
        if(debugMode) {
            sDebugModeLabel.hidden = false
        } else {
            sDebugModeLabel.hidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "LoginSegue") {
            let jvc : JobsViewController = (segue.destinationViewController as! UINavigationController).viewControllers[0] as! JobsViewController
            
            jvc.jobs = jobs
        }
    }

    @IBAction func loginAction(sender: UIButton) {
        var email = sEmailField.text
        var password = sPasswordField.text
        
        if(email.isEmpty) {
            error("You must enter an email.")

            return
        } else if(password.isEmpty) {
            self.error("You must enter a password.")

            return
        } else {
            self.info("Logging in...")
            
            apiManager.login(email, password: password, success: { () in
                self.info("Loading jobs...")
                
                self.apiManager.loadJobs({ (jobs) -> Void in
                    self.jobs = jobs
                    self.performSegueWithIdentifier("LoginSegue", sender: self)
                }, failed: { (errorMessage) -> Void in
                    println(errorMessage)
                })
            },  failed: { (errorMessage: String) in
                self.error(errorMessage)
            })
        }
    }
    
    func error(errorMessage: String) {
        sErrorLabel.text = errorMessage
        sErrorLabel.textColor = UIColor.redColor()
    }
    
    func info(infoMessage: String) {
        sErrorLabel.text = infoMessage
        sErrorLabel.textColor = UIColor.grayColor()
    }
    
    func success(successMessage: String) {
        sErrorLabel.text = successMessage
        sErrorLabel.textColor = UIColor.greenColor()
    }
    
    func clearError() {
        sErrorLabel.text = ""
    }
 
    func dismissKeyboard() {
        sEmailField.resignFirstResponder()
        sPasswordField.resignFirstResponder()
    }
}

