//
//  FavoriteProductViewController.swift
//  Shopping Card (core Data)
//
//  Created by Yveslym on 11/24/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import UIKit

class FavoriteProductViewController: UIViewController {

    // - MARK: IBOutlets
    @IBOutlet weak var tableView:UITableView!
    
    // - MARK: Properties
    
    let stack = CoreDataStack.instance
    var product = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
self.tableView.delegate = self
self.tableView.dataSource = self
      
    }

    override func viewDidAppear(_ animated: Bool) {
        
    let items = self.stack.fetchRecordsForEntity(.Product, inManagedObjectContext: self.stack.viewContext) as! [Product]
        
        self.product = items.filter{$0.favorite == true}
        self.tableView.reloadData()
    }
    
}

// - MARK: Table View life cycle

extension FavoriteProductViewController: UITableViewDelegate,UITableViewDataSource{
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
        return cell!
       
    }
}

//extension FavoriteProductViewController: stackDelegate{
//    func favoriteButtonPressed(_ indexPath: IndexPath, product: Product) {
//        // nothing to do
//    }
//    
//    func sendProduct(_ item: Product) {
//        // nothing to do
//    }
//    
//    func deleteProductFromCard(_ indexPath: IndexPath, product: Product) {
//        product.favorite = false
//    }
//    
//    
//}
//






