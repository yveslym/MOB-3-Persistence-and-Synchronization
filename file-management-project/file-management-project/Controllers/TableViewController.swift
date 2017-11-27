//
//  TableViewController.swift
//  file-management-project
//
//  Created by Yveslym on 11/3/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, documentDelegate {
    
    func buttonTag(tag: Int, selected: Bool?) {
         self.buttonTag = tag
        self.buttonSelected = selected
    }
    
    var buttonSelected: Bool? = nil
    var buttonTag : Int? = nil
    
    let delegateDoc: documentDelegate? = nil
    
    var myDocument : [Document]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func DownloadImage(document: Document?, completion: @escaping([URL]?)->Void){
        
        Networking.network(completion: {documnet in
            
            let fileManager = FileManager.default
            //check if the file exist already
            let caches = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first
            
            let filePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first as! String + "/" + (document?.collection_name)! + "/"
            
            print (filePath)
            
            if !fileManager.fileExists(atPath: filePath) {
                Downloader.download(from: document?.zipped_images_url, to: (caches?.path)!, completion: { (tempUrl) in
                
                Downloader.unZip(tempUrl: tempUrl!, destination: caches!, completion: { (unzipedURL) in
                })
                    do{
                        // get all image from the directory
                        let directoryContents = try FileManager.default.contentsOfDirectory(at: tempUrl!, includingPropertiesForKeys: nil, options: [])
                        return completion(directoryContents)
                    }
                    catch{}
            })
            }
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Networking.network { (document) in
            DispatchQueue.main.sync {
                self.myDocument = document
                self.tableView.reloadData()
                self.tableView.reloadInputViews()
                self.reloadInputViews()
//                self.tableView.cellForRow(at: <#T##IndexPath#>)
            }
        }
    }
    
    // MARK: - Table view data source
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if self.myDocument?.count != nil{
        return (self.myDocument?.count)!
        }
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ImageTableViewCell
        
        cell.downloadButton.tag = indexPath.row
        
        cell.imageName.text = self.myDocument?[indexPath.row].collection_name ?? ""
        
            if self.buttonSelected != nil {
                self.DownloadImage(document: self.myDocument?[self.buttonTag!], completion: { (imageUrlList) in
                guard let imageUrlList = imageUrlList else {return}
                DispatchQueue.main.sync {
                    cell.imageView?.image = UIImage(contentsOfFile: (imageUrlList[0].path))
                    self.tableView.reloadData()
                }
            })
            }
       
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
