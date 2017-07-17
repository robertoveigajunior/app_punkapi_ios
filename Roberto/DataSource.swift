//
//  DataSource.swift
//  Roberto
//
//  Created by Roberto Luiz Veiga Junior on 16/07/17.
//  Copyright © 2017 robertoveigajunior. All rights reserved.
//

import Foundation

class DataSource {
    
    let basePath = "https://api.punkapi.com/v2/beers"
    
    let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        
        config.allowsCellularAccess = false
        config.httpAdditionalHeaders = ["Content-Type":"application/json"]
        config.timeoutIntervalForRequest = 45.0
        config.httpMaximumConnectionsPerHost = 5
        
        return config
    }()
    
    
    func apiData(onCompletion: @escaping ([[String:Any]]?) -> Void){
        
        let session = URLSession(configuration: configuration)
        
        guard let url = URL(string: basePath) else {
            onCompletion(nil)
            return
        }
        
        session.dataTask(with: url) {(data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                onCompletion(nil)
            } else {
                guard let response = response as? HTTPURLResponse else {
                    onCompletion(nil)
                    return
                }
                
                if response.statusCode == 200 {
                    guard let data = data else {
                        onCompletion(nil)
                        return
                    }
                    
                    let json = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as! [[String: Any]]
                    
                    onCompletion(json)
             
                }
            }
        }.resume()
    }
}
