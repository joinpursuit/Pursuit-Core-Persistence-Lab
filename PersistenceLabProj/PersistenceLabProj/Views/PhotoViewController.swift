//
//  ViewController.swift
//  PersistenceLabProj
//
//  Created by Kevin Natera on 9/30/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var photoCollectionOutlet: UICollectionView!
    
    var photos = [Photo]() {
        didSet {
            photoCollectionOutlet.reloadData()
        }
    }
    
    var searchString: String? = nil {
        didSet {
            photoCollectionOutlet.reloadData()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController else { fatalError() }
        
         if let cell = sender as? PhotoCollectionViewCell, let indexPath = self.photoCollectionOutlet.indexPath(for: cell) {
        
            detailVC.pic = photos[indexPath.row]
    }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpProtocols()
        loadData(query: nil)
    }
    
    
    
    
    
    private func setUpProtocols() {
        searchBar.delegate = self
        photoCollectionOutlet.delegate = self
        photoCollectionOutlet.dataSource = self
    }
    
    private func loadData(query: String?) {
        PhotoAPIHelper.shared.getPhoto(query: query?.lowercased()) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let photosFromOnline):
                    self.photos = photosFromOnline
                    self.photoCollectionOutlet.reloadData()
                }
            }
        }
    }
}

// MARK: Extensions
extension PhotoViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchText
        loadData(query: searchString)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchString = searchBar.text
        loadData(query: searchString)
    }
}

extension PhotoViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photo = photos[indexPath.row]
        let cell = photoCollectionOutlet.dequeueReusableCell(withReuseIdentifier: "photo", for: indexPath) as! PhotoCollectionViewCell
        
        cell.configureCell(photo: photo)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
    
}
