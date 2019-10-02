//
//  FavoriteViewController.swift
//  PersistenceLabProj
//
//  Created by Kevin Natera on 10/1/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {

    @IBOutlet weak var favoritesCollectionOutlet: UICollectionView!
    
    
    var favorites = [Photo]() {
        didSet {
            favoritesCollectionOutlet.reloadData()
        }
    }
    
   private func loadData(){
        do {
            favorites = try FavoritesPersistenceHelper.manager.getFavorites()
        } catch {
            print(error)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpProtocols()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       guard let detailVC = segue.destination as? FavoriteDetailViewController else { fatalError() }
       
        if let cell = sender as? PhotoCollectionViewCell, let indexPath = self.favoritesCollectionOutlet.indexPath(for: cell) {
       
           detailVC.favPic = favorites[indexPath.row]
   }
   }

    private func setUpProtocols() {
        favoritesCollectionOutlet.dataSource = self
        favoritesCollectionOutlet.delegate = self
    }
}


extension FavoriteViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let favPhoto = favorites[indexPath.row]
        let cell = favoritesCollectionOutlet.dequeueReusableCell(withReuseIdentifier: "favPhoto", for: indexPath) as! PhotoCollectionViewCell
        
        cell.configureCell(photo: favPhoto)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
    
}
