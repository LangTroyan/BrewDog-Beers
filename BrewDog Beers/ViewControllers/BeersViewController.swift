//
//  BeersViewController.swift
//  BrewDog Beers
//
//  Created by Dylan Trujillo on 21/08/2019.
//  Copyright © 2019 Dylan Trujillo. All rights reserved.
//

import UIKit
import Kingfisher

class BeersViewController: UIViewController {
    //MARK: Constants
    static let SEGUE = "BeersSegue"
    
    //MARK: Properties
    var beers: [Beer]?
    var viewModel: BeersViewModel = BeersViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sortingButton: UIButton!
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let beers = beers {
            viewModel = BeersViewModel(with: beers)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch(segue.identifier){
        case DetailsViewController.SEGUE:
            if let detailsVC = segue.destination as? DetailsViewController, let beer = sender as? Beer {
                detailsVC.beer = beer
            }
        default:
            break
        }
    }
    
    //MARK: Actions
    
    @IBAction func sortingAction(_ sender: Any) {
        switch(viewModel.invertSortingOrder()){
        case .Desc:
            sortingButton.setImage(UIImage(named: "arrow-up"), for: .normal)
        case .Asc:
            sortingButton.setImage(UIImage(named: "arrow-down"), for: .normal)
        }
        tableView.reloadData()
    }
    
}

//MARK: Extensions

extension BeersViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: DetailsViewController.SEGUE, sender: viewModel.beers[indexPath.row])
    }
}

extension BeersViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.beers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: BeerCell.identifier) as? BeerCell {
            cell.beer = viewModel.beers[indexPath.row]
            return cell
        }
        return tableView.dequeueReusableCell(withIdentifier: BeerCell.identifier)!
    }
    
    
}

class BeerCell: UITableViewCell {
    
    static let identifier: String = "beerCell"
    
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var abvLabel: UILabel!
    
    var beer:Beer? {
        didSet {
            if let url = URL(string: beer?.imgUrl ?? ""){
                beerImageView.kf.setImage(with: url)
            }
            nameLabel.text = beer?.name ?? ""
            taglineLabel.text = beer?.tagline ?? ""
            abvLabel.text = String(beer?.abv ?? 0.0)
        }
    }
}
