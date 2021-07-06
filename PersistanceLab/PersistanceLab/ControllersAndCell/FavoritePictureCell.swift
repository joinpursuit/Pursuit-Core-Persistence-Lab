//
//  FavoritePictureCell.swift
//  PersistanceLab
//
//  Created by Yuliia Engman on 2/9/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import UIKit
import ImageKit

class FavoritePictureCell: UITableViewCell {

    @IBOutlet weak var favoritePictureImage: UIImageView!
    
    public func configureCell(for favoritePic: Hit) {
         favoritePictureImage.getImage(with: favoritePic.largeImageURL) {[weak self] (result) in
             switch result {
             case .failure:
                 DispatchQueue.main.async {
                     self?.favoritePictureImage.image = UIImage(systemName: "exclamationmark")
                 }
             case .success(let image):
                 DispatchQueue.main.async {
                     self?.favoritePictureImage.image = image
                 }
             }
         }
     }
    
}
