//
//  PhotoCollectionViewCell.swift
//  PersistenceLabProj
//
//  Created by Kevin Natera on 10/1/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageOutlet: UIImageView!
    
    func configureCell(photo: Photo) {
        ImageHelper.shared.getImage(urlStr: photo.webformatURL) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let image):
                    self.photoImageOutlet.image = image
                }
            }
        }
    }
}
