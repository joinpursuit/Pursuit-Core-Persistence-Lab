//
//  SearchPicsViewController.swift
//  PersistanceLab
//
//  Created by Yuliia Engman on 1/24/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import UIKit
import DataPersistence

class SearchPicsViewController: UIViewController {
    
    public var dataPersistence: DataPersistence<Hit>!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    private var pictures = [Hit]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    var searchQuery = "" {
        didSet {
            searchPicture(searchQuery: searchQuery)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        searchBar.delegate = self
        navigationItem.title = "Search Any Picture"
        
        searchPicture(searchQuery: "flowers")
    }
    
    private func searchPicture(searchQuery: String) {
        PictureSearchAPIClient.fetchPicture(for: searchQuery, completion: { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("error \(appError)")
            case .success(let pictures):
                self?.pictures = pictures
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController, let indexPath = collectionView.indexPath(for: sender as! SearchPictureCell) else {
            fatalError("failed to get indexPath and detailVC")
        }
        let somePicture = pictures[indexPath.row]
        detailVC.onePicture = somePicture
        detailVC.dataPersistence = dataPersistence
    }
}

extension SearchPicsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchPictureCell", for: indexPath) as? SearchPictureCell else {
            fatalError("could not downcast to PicsSearchCell")
        }
        let picture = pictures[indexPath.row]
        cell.configureCell(for: picture)
        //cell.backgroundColor = .orange
        return cell
    }
}

extension SearchPicsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let interItemSpacing: CGFloat = 10 // space between items
        let maxWidth = UIScreen.main.bounds.size.width // device's width
        //let maxSize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxWidth
        //let itemHeight: CGFloat = maxWidth
        //let numberOfItems: CGFloat = 1 // items
        //let totalSpacing: CGFloat = numberOfItems * interItemSpacing
        //let itemWidth: CGFloat = (maxWidth - totalSpacing) / numberOfItems
        return CGSize(width: itemWidth, height: itemWidth)
        //return CGSize(width: maxWidth, height: itemHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

extension SearchPicsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchText = searchBar.text else {
            print("missing search text")
            return
        }
        searchPicture(searchQuery: searchText)
    }
}
