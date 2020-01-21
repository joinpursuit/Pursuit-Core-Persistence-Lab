//
//  ViewController.swift
//  PersistenceLab
//
//  Created by Cameron Rivera on 1/16/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit

class SearchController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pictures = [PixPhoto](){
        didSet{
            DispatchQueue.main.async{
                self.collectionView.reloadData()
            }
        }
    }
    
    var userQuery = "" {
        didSet{
            PixPhotoAPIClient.getObject(PixPhotoAPIClient.getPixURL(userQuery)) { [weak self] result in
                switch result{
                case .failure(let netError):
                    DispatchQueue.main.async{
                        self?.showAlert("Picture Error", "Could not obtain photos: \(netError)")
                    }
                case .success(let photos):
                    self?.pictures = photos
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp(){
        collectionView.dataSource = self
        collectionView.delegate = self
        searchBar.delegate = self
        collectionView.backgroundColor = UIColor.darkGray
    }
    
}

extension SearchController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let xCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PixCell", for: indexPath) as? CustomCell else {
            fatalError("Could not dequeue Cell as a CustomCell")
        }
        xCell.setUp(pictures[indexPath.row])
        return xCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
}

extension SearchController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailedVC = storyboard?.instantiateViewController(withIdentifier: "DetailedController") as? DetailedController else {
            fatalError("Could not segue")
        }
        detailedVC.currentPicture = pictures[indexPath.row]
        detailedVC.currentPictureIndex = indexPath.row
        navigationController?.pushViewController(detailedVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height * 0.8)
    }
}

extension SearchController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        userQuery = text
        searchBar.resignFirstResponder()
    }
}
