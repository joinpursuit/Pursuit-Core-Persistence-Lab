//
//  PhotoViewController.swift
//  Persistence Lab
//
//  Created by Michelle Cueva on 9/30/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    @IBOutlet weak var photoSearchBar: UISearchBar!
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    var photos = [Photo]() {
        didSet {
            photoCollectionView.reloadData()
        }
    }
    
    var searchString = "" {
        didSet {
            let userStr = searchString.replacingOccurrences(of: " ", with: "+")
            loadData(searchString: userStr)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoCollectionView.dataSource = self
        loadData(searchString: "")
        photoSearchBar.delegate = self
        photoCollectionView.delegate = self

    }
    
    private func loadData(searchString: String) {
        PhotoAPIClient.manager.getPhotosFromOnline(searchTxt: searchString) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let photosFromOnline):
                    self.photos = photosFromOnline
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

extension PhotoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? CustomCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let photo = photos[indexPath.row]
        
        ImageHelper.shared.getImage(urlStr: photo.webformatURL) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let imageFromOnline):
                    cell.photoImage.image = imageFromOnline
                    
                case .failure( let error):
                    print(error)
                }
            }
        }
        
        return cell
    }
}

extension PhotoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        
        let photoDVC = storyboard.instantiateViewController(withIdentifier: "PhotoDetailViewController") as! PhotoDetailViewController
        
        let currentPhoto = photos[indexPath.row]
        
        photoDVC.photo = currentPhoto
        
        self.navigationController?.pushViewController(photoDVC, animated: true)
    }
}

extension PhotoViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchText
    }
}
