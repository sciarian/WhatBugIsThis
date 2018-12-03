//
//  MainMenuViewController.swift
//  WhatBugIsThis
//
//  Created by user144818 on 12/2/18.
//  Copyright © 2018 user144818. All rights reserved.
//

import UIKit
import Firebase

class MainMenuViewController: UIViewController, BugCatcherDelegate{
    
    fileprivate var ref: DatabaseReference?
    
    func getEntries(entries: [Catch]) {
        print("\nAdding entries\n")
        self.entries += entries
        print("Total number of entries in main view controller...\(String(describing: self.entries.count))")
    }
    
    
    //LABELS
    @IBOutlet weak var usernameLabel:      UILabel!
    @IBOutlet weak var weatherLabel:       UILabel!
    @IBOutlet weak var temperatureLabel:   UILabel!
    @IBOutlet weak var weatherReportLabel: UILabel!
    
    //IMAGES
    @IBOutlet weak var weatherIcon: UIImageView!
    
    //DARK WEATHER API INSTANCE
    let wAPI = DarkSkyWeatherService.getInstance()
    
    //HELPER VAR
    var tempUsername: String?
    var entries:[Catch] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //DONE: Update catcher name:
        self.usernameLabel.text = self.tempUsername
        print("\nUsername label text: \(self.usernameLabel.text!)\n")
        
        //DONE: Get todays weather conditions
        getWeather()
        
        //UPDATE FIREBASE DATABASE
        //self.ref = Database.database().reference()
        //self.registerForFireBaseUpdates()
    }
    
    fileprivate func registerForFireBaseUpdates()
    {
        self.ref!.child("history").observe(.value, with: { snapshot in
            if let postDict = snapshot.value as? [String : AnyObject] {
                var tmpItems = [Catch]()
                for (_,val) in postDict.enumerated() {
                    let entry       = val.1 as! Dictionary<String,AnyObject>
                    let pic         = entry["pic"] as! UIImageView?
                    let timestamp   = entry["timestamp"] as! String?
                    let description = entry["description"] as! String?
                    tmpItems.append(Catch(pic: pic?.image, timestamp: timestamp!.description, description: description!))
                }
                self.entries = tmpItems
            }
        })
    }
   
/*
    //FIREBASE DICTIONAIRY IMPLEMENTATION
    func toDictionary(vals: Catch) -> NSDictionary {
        return [
            "timestamp"   : NSString(string:  vals.timestamp!),
            "pic"    : UIImageView(image: vals.pic) ,
            "description" : NSString(string:  vals.description!),
        ]
    }
 */
 
    
    //Helper function to get weather.
    func getWeather(){
        wAPI.getWeatherForDate(date: Date(), forLocation: (42.963686, -85.888595)) { (weather) in
            if let w = weather {
                DispatchQueue.main.async {
                    // DONE: Bind the weather object attributes to the view here
                    print("Weather report icon name: \(w.iconName)")
                    self.weatherIcon.image = UIImage(named: w.iconName)
                    self.temperatureLabel.text = "\(w.temperature.rounded())º"
                    self.weatherReportLabel.text = w.summary
                }
            }
        }
    }

    //Exit button pressed
    @IBAction func exitMainMenu(_ sender: Any) {
        self.viewWillDisappear(true)
        self.dismiss(animated: true, completion: nil)
    }

    //Force view to disappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    
    //SEGUE

    //If we are going to the bug catch table view then send them our entries.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "catchListSegue" {
            if let dest = segue.destination as? BugCatchTableViewController {
                    print("\nSending entries to the main view controller\n")
                    dest.entries += self.entries
                }
            }
        
        
        if segue.identifier == "segueToBugCatcher" {
            if let dest = segue.destination as? BugCatcherViewController {
                dest.delegate = self
            }
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
