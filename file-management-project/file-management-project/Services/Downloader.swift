//
//  Downloader.swift
//  file-management-project
//
//  Created by Yveslym on 10/31/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import Foundation
import Zip
class Downloader{
    
    static func download(from link: String?, to localUrl:String, completion: @escaping (URL?)->Void){
        
        //get the download link and local url (path)
        guard let link = link else {return}
        
        let url = URL(string: link)
        
        var request = URLRequest(url: url!)
        
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            guard let tempLocalUrl = tempLocalUrl else {return completion(nil)}
            return completion(tempLocalUrl)
        }
        task.resume()
    }
    
    static func unZip(tempUrl:URL, destination: URL, completion:@escaping(URL?)->Void){
        do{
            Zip.addCustomFileExtension("tmp")
            try Zip.unzipFile(tempUrl, destination: destination, overwrite: true, password: nil, progress: { (progress) -> () in
                print(progress)
            }) // Unzip
        }
        catch _{
            print("error when unzipping")
        }
    }
}










