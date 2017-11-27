//
//  ProductViewController.swift
//  Shopping Card (core Data)
//
//  Created by Yveslym on 11/22/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import UIKit
import CoreData

class ProductViewController: UIViewController {
    
    // - MARK: Properties
    let stack = CoreDataStack.instance
    var currentUser = User.instance
    weak var delegate: stackDelegate?
    var product = [Product]()
    let cellSpacingHeight: CGFloat = 5
    
    // - MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // -MARK: View Controller Life Cycle
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "edit"{
            let editVC = segue.destination as! EditProductViewController
            editVC.item = sender as! Product
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.delegate = self
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // fetch current user
        self.currentUser = {
            
            // fetch list of users
            let users = self.stack.fetchRecordsForEntity(.User, inManagedObjectContext: self.stack.viewContext) as! [User]
            
            // filter current user by comparing user uid
            let user = users.filter{$0.uid == UserDefaults.standard.value(forKey: "uid") as? String}.first
            
            return user!
        }()
        
        // fetch product and filter only product that's not added yet
        let productList = stack.fetchRecordsForEntity(.Product, inManagedObjectContext: stack.viewContext) as! [Product]
        self.product = productList.filter{$0.added == false}
        self.tableView.reloadData()
        
        
    }
}

// - MARK: Table View Life Cycle

extension ProductViewController: UITableViewDelegate,UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.product.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ProductTableViewCell
        cell?.delegate = self
        
        let item = product[indexPath.row]
        cell?.dateLabel.text = item.date
        cell?.titleLabel.text = item.title
        cell?.favoriteButton.isSelected = item.favorite
        cell?.addedButton.isSelected = item.added
        cell?.quantityLabel.text = "x\(item.quantity)"
        cell?.item = item
        cell?.indexPath = indexPath
        
        //set up cell UI
        cell?.contentView.backgroundColor = UIColor.clear
        let whiteRoundedView : UIView = UIView(frame: CGRect(x: 10, y: 8, width: self.view.frame.size.width - 20, height: 120))
        
        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 0.9])
        cell?.contentView.addSubview(whiteRoundedView)
        cell?.contentView.sendSubview(toBack: whiteRoundedView)
        cell?.backgroundColor = UIColor.white
        cell?.layer.borderColor = UIColor.black.cgColor
        cell?.layer.borderWidth = 1
        cell?.layer.cornerRadius = 8
        cell?.clipsToBounds = true
        return cell!
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        //let shoppingCard = self.currentUser.shoppingCard
        
        // set up the edit action
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (rowAction, indexPath) in
            self.performSegue(withIdentifier: "edit", sender: self.product[indexPath.row])
        }
        
        
        editAction.backgroundColor = UIColor.init(red: 74/255, green: 185/255, blue: 211/255, alpha: 1)
        
        // - MARK: Delete from product action
        
        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete") { (rowAction, indexPath) in
            self.product[indexPath.row].added = false
            self.stack.delete(context: self.stack.viewContext, item: self.product[indexPath.row])
            self.product = self.stack.fetchRecordsForEntity(.Product, inManagedObjectContext: self.stack.viewContext) as! [Product]
            self.tableView.reloadData()
            
        }
        deleteAction.backgroundColor = UIColor.init(red: 232/255, green: 49/255, blue: 90/255, alpha: 1)
        
        // - MARK: Add to Shopping card action
        
        let addTocard = UITableViewRowAction(style: .normal, title: "Insert To Card") { (rowAction, indexPath) in
            
            
            // set added to true
            self.product[indexPath.row].added = true
            
            // create a new user shopping card
            if self.currentUser.shoppingCard == nil{
                
                self.currentUser.shoppingCard = {
                    let newCard = ShoppingCard(context: self.stack.viewContext)
                    newCard.addToProduct(NSOrderedSet(object: self.product[indexPath.row]))
                    newCard.user = self.currentUser
                    return newCard
                }()
                self.stack.saveTo(context: self.stack.viewContext)
                
                // fetch product and filter only product that's not added yet
                let productList = self.stack.fetchRecordsForEntity(.Product, inManagedObjectContext: self.stack.viewContext) as! [Product]
                self.product = productList.filter{$0.added == false}
                self.tableView.reloadData()
            }
                // add new product in existing user shopping card
            else{
                self.currentUser.shoppingCard?.addToProduct(NSOrderedSet(object: self.product[indexPath.row]))
               
                self.stack.saveTo(context: self.stack.viewContext)
                
                // fetch product and filter only product that's not added yet
                let productList = self.stack.fetchRecordsForEntity(.Product, inManagedObjectContext: self.stack.viewContext) as! [Product]
                self.product = productList.filter{$0.added == false}
                self.tableView.reloadData()
            }
        }
        addTocard.backgroundColor = UIColor.init(red: 123/255, green: 245/255, blue: 160/255, alpha: 1)
        
        return [editAction,deleteAction,addTocard]
    }
    
}

// - MARK: Core Deta Stack Delegate Operation

extension ProductViewController: stackDelegate{
    func deleteProductFromCard(_ indexPath: IndexPath, product: Product) {
        // nothing to do
    }
    
    func sendProduct(_ item: Product) {
        //nothing to do
    }
    
    func favoriteButtonPressed(_ indexPath: IndexPath, product: Product) {
        if product.favorite{
            product.favorite = false
        }
        else{
            product.favorite = true
        }
        self.stack.saveTo(context: stack.viewContext)
        self.product = self.stack.fetchRecordsForEntity(.Product, inManagedObjectContext: stack.viewContext) as! [Product]
        self.tableView.reloadRows(at: [indexPath], with: .fade)
        
    }
}

// - MARK: keyboard extension, dismis the keyboard by touching anywhere in the screen
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}






