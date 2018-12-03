//
//  MainMenuViewController.swift
//  WhatBugIsThis
//
//  Created by user144818 on 12/2/18.
//  Copyright © 2018 user144818. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //DONE: Update catcher name:
        self.usernameLabel.text = self.tempUsername
        print("\nUsername label text: \(self.usernameLabel.text!)\n")
        
        //DONE: Get todays weather conditions
        getWeather()
    }
    
    //Helper function to get weather.
    func getWeather(){
        wAPI.getWeatherForDate(date: Date(), forLocation: (42.963686, -85.888595)) { (weather) in
            if let w = weather {
                DispatchQueue.main.async {
                    // DONE: Bind the weather object attributes to the view here
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
