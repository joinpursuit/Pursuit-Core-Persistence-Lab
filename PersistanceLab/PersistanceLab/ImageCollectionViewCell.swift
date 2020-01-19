//
//  ImageCollectionViewCell.swift
//  PersistanceLab
//
//  Created by Liubov Kaper  on 1/18/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var image: UIImageView!
    
    
    public func configureCell(for imageInfo: Hit) {
        
        image.getImage(with: imageInfo.webformatURL ?? "") { (result) in
            switch result {
            case .failure(let appError):
                print("error: \(appError)")
            case .success(let image):
                DispatchQueue.main.async {
                    self.image.image = image
                }
            }
        }
    }
    
}
