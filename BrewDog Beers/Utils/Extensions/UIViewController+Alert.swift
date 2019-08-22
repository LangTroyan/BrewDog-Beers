//
//  UIViewController+Alert.swift
//  BrewDog Beers
//
//  Created by Trujillo Baez, Dylan Alfonso (ES - Barcelona) on 21/08/2019.
//  Copyright © 2019 Dylan Trujillo. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlertWith(title: String, message: String, style: UIAlertController.Style = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: "OK", style: .default){
            (action) in
                self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
}
