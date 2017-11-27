//
//  CreateProductViewController.swift
//  Shopping Card (core Data)
//
//  Created by Yveslym on 11/23/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import UIKit

class CreateProductViewController: UIViewController {
    let stack = CoreDataStack.instance
   
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var quantity:UITextField!
    
    @IBAction func savedButtonTaped(_ sender: Any){
        guard let name = name.text, let quantity = Int64(quantity.text!) else {return}
        let product =  Product(context: stack.privateContext)
        
        product.favorite = false
        product.quantity = quantity
        product.title = name
        let date = Date()
        let formater = DateFormatter()
        formater.dateFormat = "MM-dd-yyy"
        let formatedDate = formater.string(from: date)
        product.date = formatedDate
        stack.saveTo(context: stack.privateContext)
        self.navigationController?.popViewController(animated: true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
