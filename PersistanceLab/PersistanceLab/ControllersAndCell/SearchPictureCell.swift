//
//  SearchPictureCell.swift
//  PersistanceLab
//
//  Created by Yuliia Engman on 2/9/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import UIKit
import ImageKit

class SearchPictureCell: UICollectionViewCell {
    
    @IBOutlet weak var searchedImage: UIImageView!
    
    var picture: Hit?
    
    public func configureCell(for picture: Hit) {
        
        let imageURL = picture.webformatURL
        
        searchedImage.getImage(with: imageURL) {[weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.sync {
                    self?.searchedImage.image = UIImage(systemName: "exclamationmark")
                }
            case .success(let photoImage):
                DispatchQueue.main.async {
                    self?.searchedImage.image = photoImage
                }
            }
        }
    }
}



