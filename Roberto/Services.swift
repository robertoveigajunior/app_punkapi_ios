//
//  Services.swift
//  Roberto
//
//  Created by Roberto Luiz Veiga Junior on 16/07/17.
//  Copyright © 2017 robertoveigajunior. All rights reserved.
//

import UIKit

class Services {
    
    var beers = [Beer]()
    
    func getBeer(onCompletion:@escaping ([Beer]) -> ()) {
        DataSource().apiData { (list) in
            for item in list! {
                let beer = Beer()
                if let id = item["id"] {
                    beer.id = id as! Int
                }
                if let name = item["name"] {
                    beer.name = name as! String
                }
                if let abv = item["abv"] {
                    beer.abv = String(abv as! Double)
                }
                if let tagline = item["tagline"] {
                    beer.tagline = tagline as! String
                }
                if let description = item["description"] {
                    beer.description = description as! String
                }
                if let firstBrewed = item["firstBrewed"] {
                    beer.firstBrewed = firstBrewed as! String
                }
                if let imageUrl = item["image_url"] {
                    beer.imageUrl = imageUrl as! String
                }
                self.beers.append(beer)
            }
            
            onCompletion(self.beers)
        }
    }
}

extension UIImage {
    func download(url: String!, onCompletion:@escaping (UIImage) -> ()) {
        getDataByUrl(url: URL(string: url)!) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            onCompletion(UIImage(data: data)!)
        }
    }
    
    func getDataByUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
}
