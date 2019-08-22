//
//  ViewController.swift
//  BrewDog Beers
//
//  Created by Dylan Trujillo on 20/08/2019.
//  Copyright © 2019 Dylan Trujillo. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: Properties
    
    @IBOutlet weak var searchTextField: UITextField!
    
    var viewModel: SearchViewModel? = nil
    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch(segue.identifier){
        case BeersViewController.SEGUE:
            if let destinationVC = segue.destination as? BeersViewController{
                destinationVC.beers = viewModel?.search?.result
            }
        default:
            break;
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                switch(UIDevice.current.orientation){
                case .landscapeLeft, .landscapeRight:
                    self.view.frame.origin.y -= keyboardSize.height * 2
                default:
                    self.view.frame.origin.y -= keyboardSize.height
                }
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    //MARK: Actions

    @IBAction func searchAction(_ sender: Any) {
        if searchTextField.text?.isEmpty ?? true {
            self.showAlertWith(title: "Nothing to search", message: "The search text can't be empty. Please, submit at least one ingredient or a meal.")
            return
        }
        if viewModel == nil {
            viewModel = SearchViewModel()
        }
        showSpinner(onView: view)
        viewModel?.search(searchText: searchTextField.text ?? "", successHandler: {
            self.removeSpinner()
            self.performSegue(withIdentifier: BeersViewController.SEGUE, sender: sender)
        }, errorHandler: { message in
            self.removeSpinner()
            self.showAlertWith(title: "Error", message: message)
        })
    }
    

}

