//
//  ShoppingCardViewController.swift
//  Shopping Card (core Data)
//
//  Created by Yveslym on 11/24/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import UIKit

class ShoppingCardViewController: UIViewController {

    // - MARK: Properties
    var currentUser = User.instance
    var product = [Product]()
    let stack = CoreDataStack.instance
    
    // - MARK: IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    
    
    // - MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    override func viewDidAppear(_ animated: Bool) {
        
        
       // retrieve user from core data
        self.currentUser = {
            
            let users = self.stack.fetchRecordsForEntity(.User, inManagedObjectContext: self.stack.viewContext) as! [User]
            let user = users.filter({ (object) -> Bool in
                return UserDefaults.standard.value(forKey: "uid") as? String == object.uid
            })
            return user.first!
        }()
        
        let shoppingCard = self.currentUser.shoppingCard
        
        if shoppingCard != nil{
            self.product = shoppingCard?.product?.array as! [Product]
            self.tableView.reloadData()

        }
    }
}

    // - MARK: Table View Operations
extension ShoppingCardViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.product.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ProductTableViewCell
        
        let item = self.product[indexPath.row]
        cell?.dateLabel.text = item.date
        cell?.quantityLabel.text = "x\(item.quantity)"
        cell?.titleLabel.text = item.title
        cell?.item = item
        cell?.indexPath = indexPath
        cell?.delegate = self
        
        return cell!
    }
    
}

// - MARK: Core Data Stack Delegation Operation

extension ShoppingCardViewController: stackDelegate{
    func favoriteButtonPressed(_ indexPath: IndexPath, product: Product) {
        // do nothing
    }
    
    func sendProduct(_ item: Product) {
        // do nothing
    }
    
    func deleteProductFromCard(_ indexPath: IndexPath, product: Product) {
        
        product.added = false
        self.currentUser.shoppingCard?.removeFromProduct(NSOrderedSet(object: product))
        
       self.stack.saveTo(context: self.stack.viewContext)
        self.product = (self.currentUser.shoppingCard?.product?.array as? [Product])!
        self.tableView.reloadData()
    }
    
    
}








