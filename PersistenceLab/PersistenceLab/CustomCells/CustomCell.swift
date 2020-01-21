//
//  CustomCell.swift
//  PersistenceLab
//
//  Created by Cameron Rivera on 1/16/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit

class CustomCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    
    var imageURL = ""
    
    override func prepareForReuse() {
        super.prepareForReuse()
        image.image = nil
    }
    
    func setUp(_ picture: PixPhoto) {
        imageURL = picture.largeImageURL
        image.getImage(picture.largeImageURL) { [weak self] result in
            switch result {
            case .failure(let netError):
                print("Encountered error: \(netError).")
            case .success(let image):
                DispatchQueue.main.async{
                    if self?.imageURL == picture.largeImageURL{
                        self?.image.image = image
                    }
                }
            }
        }
    }
}
