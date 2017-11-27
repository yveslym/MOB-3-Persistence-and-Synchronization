//
//  LoginRegisterViewController.swift
//  Shopping Card (core Data)
//
//  Created by Yveslym on 11/24/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import UIKit

class LoginRegisterViewController: UIViewController {
    
    // - MARK: Properties
    
    let stack = CoreDataStack.instance
    var currentUser = User.instance
    // - MARK: IBOutlets
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    // - MARK: IBActions
    
    @IBAction func login(_ sender: Any) {
    
        guard let username = username.text, let password = password.text else {return}
        
        // fetch user
        let users = self.stack.fetchRecordsForEntity(.User, inManagedObjectContext: self.stack.viewContext) as? [User]
       
        // filter current user
        
        let user: User? = users?.filter{$0.username == username && $0.password == password}.first
        
        
        if user?.uid != nil{

            PersistUser.firstTimeLogin(uid: self.currentUser.uid!)
        self.performSegue(withIdentifier: "login", sender: nil)
            }
       
        // present Alert VC user does not exist
        else{
            let alert = UIAlertController(title: "Credential Incorrect", message: "Username or Password incorrect", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func register(_ sender: Any) {
        
        guard let username = username.text, let password = password.text else {return}
        
        
        self.currentUser.uid = UUID().uuidString
        self.currentUser.password = password
        self.currentUser.username = username
        self.stack.saveTo(context: self.stack.viewContext)
        
        PersistUser.firstTimeLogin(uid: self.currentUser.uid!)
        
        self.performSegue(withIdentifier: "login", sender: nil)
    }
    
    // - MARK: View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.hideKeyboardWhenTappedAround()
    }
}
