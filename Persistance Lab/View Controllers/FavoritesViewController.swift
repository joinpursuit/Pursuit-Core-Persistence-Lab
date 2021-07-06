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
    
    private var refreshControl: UIRefreshControl!
    
    var favImages = [Things]() {
        didSet {
            DispatchQueue.main.async {
                self.updateUI()
                self.favCV.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favCV.dataSource = self
        favCV.delegate = self
        updateUI()
    }
    
    func updateUI () {
        do {
            favImages = try PersistenceHelper.loadPhotos()
        } catch {
            print("count load favortites: \(error)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "second" {
            guard let detailVC = segue.destination as? DetailViewController, let indexpath = favCV.indexPathsForSelectedItems?.first else {
                fatalError()
            }
            detailVC.photos = favImages[indexpath.row]
            detailVC.favButton.isEnabled = false
        }
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
        cell.delegate = self 
        return cell
    }
}

extension FavoritesViewController: favCellDelegate {
    func didLongPress(cell: FavCell) {
        guard let indexpath = favCV.indexPath(for: cell) else {
            return
        }
        // present an action sheet
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] (alertAction) in
            self?.deleteFav(indexpath: indexpath)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    private func deleteFav(indexpath: IndexPath) {
        do {
            try PersistenceHelper.deletePic(index: indexpath.row)
            // delete from image from imageobjects
            favImages.remove(at: indexpath.row)
            
            // delete cell from colletion view
            favCV.deleteItems(at: [indexpath])
        } catch {
            print("\(error)")
        }
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

