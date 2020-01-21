//
//  FavouritesController.swift
//  PersistenceLab
//
//  Created by Cameron Rivera on 1/16/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit

class FavouritesController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var favourites = [PixPhoto]() {
        didSet{
            collectionView.reloadData()
        }
    }
    var persistenceHandler = PersistenceHelper<PixPhoto>(fileName: "Favourites Pictures")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUp()
    }
    
    private func setUp(){
        collectionView.delegate = self
        collectionView.dataSource = self
        do {
            favourites = try persistenceHandler.getObjects()
        } catch {
            showAlert("Loading Error", "Could not load favourites from device")
        }
    }
    

}

extension FavouritesController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let xCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PixCell", for: indexPath) as? CustomCell else{
            fatalError("Could not dequeue cell as Custom Cell")
        }
        xCell.setUp(favourites[indexPath.row])
        return xCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favourites.count
    }
}

extension FavouritesController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailedVC = storyboard?.instantiateViewController(withIdentifier: "DetailedController") as? DetailedController else {
            fatalError("Could not segue")
        }
        detailedVC.currentPictureIndex = indexPath.row
        detailedVC.seguedFromFavourites = true
        navigationController?.pushViewController(detailedVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width * 0.9, height: UIScreen.main.bounds.size.height * 0.8)
    }
}
