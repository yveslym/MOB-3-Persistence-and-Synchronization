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
    
    let tableview = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "table") as! TableViewController
    var select: Bool? = nil
    @IBAction func downloadImage(_ sender:Any) {
        
        tableview.tableView.delegate = self as? UITableViewDelegate
        tableview.tableView.dataSource = self as? UITableViewDataSource
         self.downloadButton.isSelected = true
        weak var myDocumentDelegate : documentDelegate?
        myDocumentDelegate?.buttonTag(tag: self.downloadButton.tag, selected: self.downloadButton.isSelected)
        
       
        self.tableview.viewWillAppear(false)
        
        self.tableview.tableView.reloadData()
        
        self.tableview.reloadInputViews()
        self.tableview.tableView.reloadInputViews()
        
    }
    
    func selected(completion:@escaping(Bool?)->Void){
        return completion (select)
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
