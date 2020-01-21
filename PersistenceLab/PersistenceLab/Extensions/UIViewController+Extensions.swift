//
//  UIViewController+Extensions.swift
//  PersistenceLab
//
//  Created by Cameron Rivera on 1/16/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit

// Show presents an Alert.
extension UIViewController{
    func showAlert(_ title: String, _ message: String, completion: ((UIAlertAction) -> ())? = nil){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "ok", style: .default, handler: completion)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
}
