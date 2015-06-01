//
//  ViewController.swift
//  Ship
//
//  Created by Andrew Page on 5/15/15.
//  Copyright (c) 2015 Ship. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var sEmailField: UITextField!
    @IBOutlet weak var sPasswordField: UITextField!
    @IBOutlet weak var sErrorLabel: UILabel!
    
    var apiManager: SAPIManager!
    var jobs: [SJob]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearError()
        
        apiManager = SAPIManager()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "LoginSegue") {
            let jvc : JobsViewController = segue.destinationViewController as! JobsViewController

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
            error("You must enter a password.")
            return
        } else {
            clearError()
            
            apiManager.login(email, password: password, success: { () in
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
        sErrorLabel.text = errorMessage;
    }
    
    func clearError() {
        sErrorLabel.text = ""
    }
}

