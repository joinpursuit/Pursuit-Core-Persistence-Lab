//
//  FavoritesCell.swift
//  PersistanceLab
//
//  Created by Liubov Kaper  on 1/19/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import UIKit

class FavoritesCell: UITableViewCell {

    @IBOutlet weak var favoriteImage: UIImageView!
    

    public func configureTableViewCell(for favImage: Hit) {
        favoriteImage.getImage(with: favImage.webformatURL ?? "") { (result) in
            switch result {
            case .failure(let appError):
                print("error: \(appError)")
            case .success(let image):
                DispatchQueue.main.async {
                    self.favoriteImage.image = image
                }
            }
        }
    }
}
