//
//  ProductTableViewCell.swift
//  Shopping Card (core Data)
//
//  Created by Yveslym on 11/22/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    // - MARK: IBOutlets
    
    @IBOutlet weak var objectImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var quantityLabel:UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var addedButton: UIButton!
    weak var delegate : stackDelegate?
    var indexPath: IndexPath!
    var item: Product!
    let stack = CoreDataStack.instance
    
    
    @IBAction func remove(_ sender: Any) {
    
        self.delegate?.deleteProductFromCard(indexPath, product: item)
    }
    
    @IBAction func favoriteButtonPressed(_ sender: Any){
        
        self.delegate?.favoriteButtonPressed(indexPath, product: item)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layoutMargins = UIEdgeInsetsMake(8, 0, 8, 0)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}



