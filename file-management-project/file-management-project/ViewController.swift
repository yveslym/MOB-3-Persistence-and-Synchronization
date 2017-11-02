//
//  ViewController.swift
//  file-management-project
//
//  Created by Yveslym on 10/31/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import UIKit
import Zip

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Networking.network(completion: {documnet in
    let url = URL(string: (documnet?[2].zipped_images_url)!)
            let localUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            let filePath = localUrl?.appendingPathComponent((documnet?[2].collection_name)!)
            
            let sessionConfig = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfig)
            let request = URLRequest(url: url!)
            
            let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
                if let tempLocalUrl = tempLocalUrl, error == nil {
                    // Success
                    if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                        print("Success: \(statusCode)")
                    }
                    
                    do {
                       try FileManager.default.copyItem(at: tempLocalUrl, to: localUrl!)
                        let unzipDirectory = try Zip.quickUnzipFile(filePath!) // Unzip
                        
                    } catch (let writeError) {
                        print("error writing file \(localUrl) : \(writeError)")
                    }
                    
                } else {
                    print("Failure: %@", error?.localizedDescription);
                }
            }
            task.resume()
        
})
}
}
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
//let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
//let path2 = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
//let urlPath2 = URL(fileURLWithPath: path)
//           // let filePath = urlPath.URLByAppendingPathComponent(documnet?[1].zipped_images_url).path!
//            let filePath = urlPath2.appendingPathComponent((documnet?[1].collection_name)!).path
//
//            let fileManager = FileManager.default
//            if fileManager.fileExists(atPath: filePath) {
//                print("FILE AVAILABLE")
//            } else {
//                print("FILE NOT AVAILABLE")
//            }
//
//
//guard let urlPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
////
////            // get the file path
////            let fileManager = FileManager.default
//            let filePath2 = urlPath.appendingPathComponent((documnet?[1].collection_name)!)
////                fileManager.fileExists(atPath: filePath)
//
//            var request = URLRequest(url: url!)
//
//            request.httpMethod = "GET"
//
//            let session = URLSession.shared
//            let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
//                if error != nil{
//                    print("task return error")
//                    return
//                }
//                do{
//
//                    try FileManager.default.copyItem(at: tempLocalUrl!, to: filePath2)
//
//                }
//                catch{print ("error happen when downloading zip")}
//            }
//            task.resume()
//        })
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }

        
//}

