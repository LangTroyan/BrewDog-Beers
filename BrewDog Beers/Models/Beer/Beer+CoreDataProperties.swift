//
//  Beer+CoreDataProperties.swift
//  BrewDog Beers
//
//  Created by Lang Troyan on 20/08/2019.
//  Copyright © 2019 Dylan Trujillo. All rights reserved.
//
//

import Foundation
import CoreData


extension Beer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Beer> {
        return NSFetchRequest<Beer>(entityName: "Beer")
    }

    @NSManaged public var foodPairing: NSObject?
    @NSManaged public var abv: Double
    @NSManaged public var imgUrl: String?
    @NSManaged public var firstBrewed: String?
    @NSManaged public var tagline: String?
    @NSManaged public var name: String?
    @NSManaged public var id: Int16
    @NSManaged public var text: String?

}
