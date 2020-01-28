//
//  PicsSearchCellCollectionViewCell.swift
//  PersistanceLab
//
//  Created by Yuliia Engman on 1/24/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import UIKit

class PicsSearchCell: UICollectionViewCell {
    
    @IBOutlet weak var searchedImage: UIImageView!
    
    var picture: Hit?
    
    public func configureCell(for picture: Hit) {
        
        let imageURL = picture.largeImageURL
        
        searchedImage.getImage(with: imageURL)
    }
    
    
}
