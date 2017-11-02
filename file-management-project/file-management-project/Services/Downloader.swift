//
//  Downloader.swift
//  file-management-project
//
//  Created by Yveslym on 10/31/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import Foundation
class Downloader{
    
    static func download(from link: String?, to localUrl:String, completion: @escaping (URL)->Void){
       
        //get the download link and local url (path)
        guard let link = link else {return}
        guard let localUrl = URL(string:localUrl) else {return}
        
        let url = URL(string: link)
        
        var request = URLRequest(url: url!)
        
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if error != nil{
                print("tast return error")
            }
            do{
                try FileManager.default.copyItem(at: tempLocalUrl!, to: localUrl)
                
                return completion(localUrl)
            }
            catch{print ("error happen when downloading zip")}
        }
        task.resume()
    }
}
