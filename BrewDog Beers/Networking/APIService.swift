//
//  APIService.swift
//  BrewDog Beers
//
//  Created by Lang Troyan on 20/08/2019.
//  Copyright © 2019 Dylan Trujillo. All rights reserved.
//

import UIKit

enum Result<T>{
    case Success(T)
    case Error(String)
}

enum Parameter: String{
    case food
}

class APIService: NSObject {
    
    // MARK: Properties
    let baseUrl: String = "https://api.punkapi.com/v2/beers"
    
    // MARK: Methods
    func getDataWith(parameters: [Parameter:String]? = nil, completion: @escaping (Result<[String: AnyObject]>) -> Void){
        var mutableUrl = baseUrl
        if let parameters = parameters {
            mutableUrl += "?"
            let _ = parameters.map{ mutableUrl += "\($0.key)=\($0.value)&"}
        }
        
        guard let url = URL(string: mutableUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else { return }
            guard let data = data else { return }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [String:AnyObject] {
                    DispatchQueue.main.async{
                        completion(.Success(json))
                    }
                }
            }
            catch let error {
                return
            }
        }.resume()
    }
}
