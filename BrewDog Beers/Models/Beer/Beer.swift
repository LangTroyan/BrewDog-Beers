//
//  Beer.swift
//  BrewDog Beers
//
//  Created by Trujillo Baez, Dylan Alfonso (ES - Barcelona) on 22/08/2019.
//  Copyright © 2019 Dylan Trujillo. All rights reserved.
//

import Foundation

public class Beer: NSObject, NSCoding {
    
    var id : Int?
    var name : String?
    var text : String?
    var imgUrl : String?
    var abv : Double?
    var tagline : String?
    var firstBrewed : String?
    var foodPairing : [String]?
    
    public required init?(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: "id") as? Int
        name = aDecoder.decodeObject(forKey: "name") as? String
        text = aDecoder.decodeObject(forKey: "description") as? String
        imgUrl = aDecoder.decodeObject(forKey: "image_url") as? String
        abv = aDecoder.decodeObject(forKey: "abv") as? Double
        tagline = aDecoder.decodeObject(forKey: "tagline") as? String
        firstBrewed = aDecoder.decodeObject(forKey: "first_brewed") as? String
        foodPairing = aDecoder.decodeObject(forKey: "food_pairing") as? [String]
    }
    
    public required init(with dictionary: [String:AnyObject]) {
        id = dictionary["id"] as? Int
        name = dictionary["name"] as? String
        text = dictionary["description"] as? String
        imgUrl = dictionary["image_url"] as? String
        abv = dictionary["abv"] as? Double
        tagline = dictionary["tagline"] as? String
        firstBrewed = dictionary["first_brewed"] as? String
        foodPairing = dictionary["food_pairing"] as? [String]
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey:"id")
        aCoder.encode(name, forKey:"name")
        aCoder.encode(text, forKey:"description")
        aCoder.encode(imgUrl, forKey:"image_url")
        aCoder.encode(abv, forKey:"abv")
        aCoder.encode(tagline, forKey: "tagline")
        aCoder.encode(firstBrewed, forKey:"first_brewed")
        aCoder.encode(foodPairing, forKey:"food_pairing")
    }
}
