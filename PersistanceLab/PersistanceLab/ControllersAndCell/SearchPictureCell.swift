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
        
        let imageURL = picture.largeImageURL
        
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

//import UIKit
//import ImageKit
//
//class CountryCollectionViewCell: UICollectionViewCell {
//
//    @IBOutlet weak var countryImage: UIImageView!
//    @IBOutlet weak var countryNameLabel: UILabel!
//    @IBOutlet weak var capitalLabel: UILabel!
//    @IBOutlet weak var populationLabel: UILabel!
//
//    public func configureCell(for country: Country) {
//        countryNameLabel.text = country.name
//        capitalLabel.text = country.capital
//        populationLabel.text = "Population: \(country.population.description)"
//
//        let imageURL = "https://www.countryflags.io/\(country.alpha2Code)/shiny/64.png"
//
//        countryImage.getImage(with: imageURL) {(result) in
//            switch result {
//            case .failure:
//                DispatchQueue.main.async {
//                    self.countryImage.image = UIImage(systemName: "photo.fill")
//                }
//            case .success(let countryImage):
//                DispatchQueue.main.async {
//                    self.countryImage.image = countryImage
//                }
//            }
//        }
//    }
//}


