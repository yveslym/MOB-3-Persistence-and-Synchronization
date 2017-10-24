//
//  ViewController.swift
//  simple persistance
//
//  Created by Yveslym on 10/23/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var bgTime: UIImageView!
    @IBOutlet weak var switchButton: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let weWantMidnight = UserDefaults.standard.bool(forKey: "midnightThemeOn")
        if weWantMidnight {
            self.switchToNight()
        }
        else{
            self.switchToDay()
        }
    }
    
    @IBAction func switchFlipped(_ sender: Any) {
        
        if self.switchButton.isOn{
            self.switchToNight()
            UserDefaults.standard.set(true, forKey: "midnightThemeOn")
        }
        else{
            self.switchToDay()
            UserDefaults.standard.set(false, forKey: "midnightThemeOn")
        }
    }
    
    func switchToNight(){
        
        self.bgTime.image = UIImage(named:"night")
    }
    func switchToDay(){
        self.bgTime.image = UIImage(named:"day")
    }
    
}

