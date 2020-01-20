//
//  FavCell.swift
//  Persistance Lab
//
//  Created by Tsering Lama on 1/19/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit
import ImageKit

class FavCell: UICollectionViewCell {
    
    @IBOutlet weak var favPhoto: UIImageView!
    
    func configreCell(fav: Things) {
        favPhoto.getImage(with: fav.largeImageURL) { [weak self ](result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
            case .success(let image):
                DispatchQueue.main.async {
                    self?.favPhoto.image = image
                }
            }
        }
    }
    
}
