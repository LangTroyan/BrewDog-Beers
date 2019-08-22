//
//  Beer+CoreDataClass.swift
//  BrewDog Beers
//
//  Created by Lang Troyan on 20/08/2019.
//  Copyright © 2019 Dylan Trujillo. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Beer)
public class Beer: NSManagedObject {
    
    public func setBeer(dictionary : [String:AnyObject]){
        
        abv = dictionary["abv"] as? Double ?? 0.0
        imgUrl = dictionary["image_url"] as? String
        firstBrewed = dictionary["first_brewed"] as? String
        tagline = dictionary["tagline"] as? String
        name = dictionary["name"] as? String
        id = dictionary["id"] as? Int16 ?? 0
        text = dictionary["description"] as? String
        foodPairing = dictionary["food_pairing"] as? NSObject
    }
    
}
