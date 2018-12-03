//
//  LoginViewController.swift
//  WhatBugIsThis
//
//  Created by user144818 on 12/2/18.
//  Copyright © 2018 user144818. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    //IMAGES
    @IBOutlet weak var logo: UIImageView!

    //LABELS
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    //TEXT FIELDS
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    //BUTTONS
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        print("\nSubmit pressed\n")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //verify user input
    func verifyInput() -> Bool{
        if let password = self.passwordField.text{
            if password == "admin" {
                return true
            }
        }
        return false
    }
    
    //Used to segue back to login screen when main menu is exited.
    @IBAction func exitMainMenu(segue: UIStoryboard){
        print("Returned from main menu")
    }

    //Segue to main menu
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if verifyInput(){
            if let dest = segue.destination.childViewControllers[0] as? MainMenuViewController {
                print("Username text field: \(self.usernameField.text!)")
                dest.tempUsername = "Welcome catcher \(self.usernameField.text!)"
            }
        }
    }
}
