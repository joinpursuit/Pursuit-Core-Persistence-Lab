//
//  SearchPicsViewController.swift
//  PersistanceLab
//
//  Created by Yuliia Engman on 1/24/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import UIKit

class SearchPicsViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var pictures = [Picture]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .blue
        searchBar.delegate = self
        
        searchPicture(searchQuery: "")
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
        guard let detailVC = segue.destination as? DetailViewController, let indexPath = collectionView.indexPath(for: sender as! PicsSearchCell) else {
            fatalError("failed to get indexPath and detailVC")
        }
        let somePicture = pictures[indexPath.row]
        detailVC.onePicture = somePicture
    }
}

extension SearchPicsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchPicsCell", for: indexPath) as? PicsSearchCell else {
            fatalError("could not downcast to PicsSearchCell")
        }
        let picture = pictures
    }
}
