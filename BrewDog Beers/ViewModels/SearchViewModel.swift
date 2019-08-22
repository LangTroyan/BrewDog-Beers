//
//  SearchViewModel.swift
//  BrewDog Beers
//
//  Created by Trujillo Baez, Dylan Alfonso (ES - Barcelona) on 21/08/2019.
//  Copyright © 2019 Dylan Trujillo. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class SearchViewModel {
    
    //MARK: Properties
    
    var search: Search?
    let context: NSManagedObjectContext?
    
    init() {
        context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    }
    
    public func search(searchText: String, successHandler: @escaping () -> Void, errorHandler:  @escaping (String) -> Void){
        let searchText = searchText.replacingOccurrences(of: " ", with: "_")
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Search")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "searchText", ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "searchText = %@", searchText)
        do {
            search = try context?.fetch(fetchRequest).first as? Search
        }
        catch let error {
            print("Could not fetch data from the actual context: \(error)")
            
        }
        if search == nil || search?.result == nil {
            getBeersFromAPI(searchText: searchText, successHandler: successHandler, errorHandler: errorHandler)
        }
        else{
            if search!.result?.isEmpty ?? true {
                errorHandler("We could not find any beer that could accompany your meal. Try again with something else.")
            }
            else{
                successHandler()
            }
        }
    }
    
    private func createSearchEntityFrom(dictionary: [String : AnyObject]) -> NSManagedObject? {
        guard let context = context else { return nil }
        
        if let searchEntity = NSEntityDescription.insertNewObject(forEntityName: "Search", into: context) as? Search {
            searchEntity.searchText = dictionary["searchText"] as? String
            searchEntity.result = [Beer]()
            if let dictionaries = dictionary["result"] as? [AnyObject]{
                for dictionary in dictionaries{
                    if let beerDictionary = dictionary as? [String:AnyObject] {
                        searchEntity.result?.append(Beer(with: beerDictionary))
                    }
                }
            }
            
            return searchEntity
        }
        return nil
    }
    
    private func saveInCoreDataWith(array: [String: AnyObject]){
        guard let context = context else { return }
        search = createSearchEntityFrom(dictionary: array) as? Search
        do {
            try context.save()
        }
        catch let error {
            print(error)
        }
    }
    
    func getBeersFromAPI(searchText: String, successHandler: @escaping () -> Void, errorHandler: @escaping (String) -> Void){
        let service = APIService()
        service.getDataWith(parameters: [.food:searchText]){ (result) in
            switch result {
            case .Success(let data):
                self.saveInCoreDataWith(array: ["searchText":searchText as AnyObject,"result":data as AnyObject])
                if self.search?.result?.isEmpty ?? true {
                    errorHandler("We could not find any beer that could accompany your meal. Try again with something else.")
                }
                else{
                    successHandler()
                }
            case .Error(let message):
                errorHandler(message)
            }
        }
    }
}
