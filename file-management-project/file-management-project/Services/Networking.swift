//
//  Networking.swift
//  file-management-project
//
//  Created by Yveslym on 10/31/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import Foundation
class Networking{
    
    static func network(completion: @escaping ([Document]?)->Void){
   let link = "https://api.myjson.com/bins/1165qr"
        guard let url = URL(string: link) else {return}
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let task = session.dataTask(with: request){data,response,error in
            do{
                guard let data = data else {return}
                let document = try JSONDecoder().decode([Document].self, from: data)
                print(document)
                return completion(document)
            }
            catch{print("error happen")}
        }
        task.resume()
        
    }
}
