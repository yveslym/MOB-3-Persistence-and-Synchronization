//
//  ViewController.swift
//  NoteApp-Core-Data
//
//  Created by Yveslym on 10/24/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var uname: UITextField!
    @IBOutlet weak var pword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func login(_ sender: Any) {

        UserDefaults.standard.set(true, forKey: "launchBefore")
        print("first time login")
        
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let bookTVC = storyboard.instantiateViewController(withIdentifier: "bookTVC")
            self.present(bookTVC,animated: true,completion:nil)
            
            }
            
        }
        

    


