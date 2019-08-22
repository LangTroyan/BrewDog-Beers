//
//  DetailsViewController.swift
//  BrewDog Beers
//
//  Created by Dylan Trujillo on 21/08/2019.
//  Copyright © 2019 Dylan Trujillo. All rights reserved.
//

import UIKit
import Kingfisher

class DetailsViewController: UIViewController {
    
    //MARK: Constants
    static let SEGUE = "DetailsSegue"
    
    // MARK: Properties
    
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var abvLabel: UILabel!
    @IBOutlet weak var pairingLabel: UILabel!
    var beer: Beer?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let beer = beer {
            if let url = URL(string: beer.imgUrl ?? ""){
                beerImageView.kf.setImage(with: url)
            }
            nameLabel.text = beer.name ?? ""
            descriptionLabel.text = beer.text ?? ""
            if let foods = beer.foodPairing {
                pairingLabel.text = ""
                var isFirstFood = true
                for food in foods {
                    if isFirstFood{
                        pairingLabel.text = "Recommended with: \(food)"
                        isFirstFood = false
                    }
                    else {
                        pairingLabel.text = "\(pairingLabel.text ?? ""), \(food)"
                    }
                }
            }
            abvLabel.text = "Alcohol by volume: \(String(beer.abv ?? 0.0)) %"
        }
    }
    
}
