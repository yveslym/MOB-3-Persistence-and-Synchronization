//
//  ImageTableViewCell.swift
//  file-management-project
//
//  Created by Yveslym on 11/3/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    @IBOutlet weak var downloadButton:UIButton!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var imageName: UILabel!
    
    var indexPath: IndexPath?
    
    @IBAction func downloadImage(_ sender:Any) {
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
