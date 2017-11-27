//
//  EditProductViewController.swift
//  Shopping Card (core Data)
//
//  Created by Yveslym on 11/23/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import UIKit

class EditProductViewController: UIViewController {
    let stack = CoreDataStack.instance
    var item: Product!
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var quantity: UITextField!
    
    @IBAction func saveButtonPressed(_ sender: Any){
        
        guard let name = name.text, let quantity = Int64(quantity.text!) else {return}
        
        let record = stack.fetchRecordsForEntity(.Product, inManagedObjectContext: stack.viewContext)
        let editItem = record.filter { (object) -> Bool in
            print("ok")
           return object == self.item
        }
        editItem[0].setValue(name, forKey: "title")
        editItem[0].setValue(quantity, forKey: "quantity")
        stack.saveTo(context: stack.viewContext)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.name.text = item.title
        self.quantity.text = String( item.quantity)
        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAround() 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
