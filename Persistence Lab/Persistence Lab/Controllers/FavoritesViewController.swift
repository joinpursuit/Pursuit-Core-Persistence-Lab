//
//  FavoritesViewController.swift
//  Persistence Lab
//
//  Created by Michelle Cueva on 9/30/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    
    var favorites = [Photo]() {
        didSet {
            favoriteCollectionView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    private func configureCollectionView() {
        favoriteCollectionView.dataSource = self
        favoriteCollectionView.delegate = self
    }
    
    private func loadData() {
        do {
            favorites = try PhotoPersistenceHelper.manager.getPhoto()
        } catch {
            print(error)
        }
    }

}

extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentFavorite = favorites[indexPath.row]
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteCell", for: indexPath) as? CustomCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        
        ImageHelper.shared.getImage(urlStr: currentFavorite.webformatURL) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let imageFromOnline):
                    cell.favoriteImage.image = imageFromOnline
                    
                case .failure( let error):
                    print(error)
                }
            }
        }
        
        return cell
    }
}

extension FavoritesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        
        let favoriteDVC = storyboard.instantiateViewController(withIdentifier: "FavoritesDetailViewController") as! FavoritesDetailViewController
        
        let currentFavorite = favorites[indexPath.row]
        
        favoriteDVC.favorite = currentFavorite
        
        self.navigationController?.pushViewController(favoriteDVC, animated: true)
    }
}
