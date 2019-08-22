//
//  BeersViewModel.swift
//  BrewDog Beers
//
//  Created by Trujillo Baez, Dylan Alfonso (ES - Barcelona) on 21/08/2019.
//  Copyright © 2019 Dylan Trujillo. All rights reserved.
//

import Foundation

public enum SortingOrder:String {
    case Asc
    case Desc
}

public class BeersViewModel {

    var beers: [Beer]
    var order: SortingOrder = .Desc
    
    init(){
        beers = [Beer]()
    }
    
    init(with beers: [Beer]){
        self.beers = beers
        sortBeers(order: .Asc)
    }
    
    public func invertSortingOrder() -> SortingOrder{
        switch(order){
        case .Asc:
            sortBeers(order: .Desc)
        case .Desc:
            sortBeers(order: .Asc)
        }
        return order
    }
    
    public func sortBeers(order: SortingOrder){
        self.order = order
        switch(order){
        case .Asc:
            beers.sort(by: { $0.abv ?? 0.0 < $1.abv ?? 0.0 })
        case .Desc:
            beers.sort(by: { $0.abv ?? 0.0 > $1.abv ?? 0.0 })
        }
    }
}
