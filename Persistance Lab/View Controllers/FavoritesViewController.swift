//
//  FavoritesViewController.swift
//  Persistance Lab
//
//  Created by Tsering Lama on 1/19/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit
import DataPersistence

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var favCV: UICollectionView!
    
    var favImages = [Things]() {
        didSet {
            self.favCV.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favCV.dataSource = self
        favCV.delegate = self
    }
    
    func updateUI () {
        
    }
}

extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favCell", for: indexPath) as? FavCell else {
            fatalError()
        }
        let aFav = favImages[indexPath.row]
        cell.configreCell(fav: aFav)
        return cell
    }
}

extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          let interspacing = CGFloat(5)
          let maxwidth = UIScreen.main.bounds.size.width
          let numOfItems = CGFloat(3)
          let totalSpacing = CGFloat(numOfItems * interspacing)
          let itemWidth = CGFloat((maxwidth - totalSpacing) / (numOfItems) )
          return CGSize(width: itemWidth, height: itemWidth)
      }
      
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
          return UIEdgeInsets(top: 5, left: 3, bottom: 5, right: 3)
      }
      
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
          return 5
      }
      
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
          return 1
      }
}
