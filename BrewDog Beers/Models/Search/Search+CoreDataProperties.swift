//
//  Search+CoreDataProperties.swift
//  BrewDog Beers
//
//  Created by Trujillo Baez, Dylan Alfonso (ES - Barcelona) on 21/08/2019.
//  Copyright © 2019 Dylan Trujillo. All rights reserved.
//
//

import Foundation
import CoreData


extension Search {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Search> {
        return NSFetchRequest<Search>(entityName: "Search")
    }

    @NSManaged public var searchText: String?
    @NSManaged public var result: [Beer]?

}
