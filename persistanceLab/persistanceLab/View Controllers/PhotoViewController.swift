//
//  PhotoViewController.swift
//  persistanceLab
//
//  Created by Sam Roman on 9/30/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    //MARK: Outlets & Variables
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchResults = [Hit]() {
        didSet{
            photoCollectionView.reloadData()
        }
    }
    
    
    //MARK: Private Methods
    private func loadSearch(str: String){
        PhotoAPIClient.shared.getPhotos(str: str) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let results):
                    self.searchResults = results.hits
                }
            }
        }
    }
    
    
    
    
    override func viewDidLoad() {
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        searchBar.delegate = self
        super.viewDidLoad()

    }

}


//MARK: - CollectionView Extension

extension PhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return searchResults.count
}

func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let hit = searchResults[indexPath.row]
    guard let cell = photoCollectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCollectionViewCell else {
        return UICollectionViewCell() }
    ImageHelper.shared.fetchImage(urlString: hit.previewURL ) { (result) in
        DispatchQueue.main.async {
            switch result {
            case .success(let image):
                cell.cellPhoto.image = image
                print("successful image load")
            case .failure(let error):
                print(error)
            }
            
        }
    }
    return cell
}

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedCell = sender as! PhotoCollectionViewCell
        let index = (photoCollectionView.indexPath(for: selectedCell)?.row)!
        if segue.identifier == "segue" {
            let destination = segue.destination as! PhotoSearchDetailViewController
            destination.photo = searchResults[index]
        }
    }

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       return CGSize(width: 135, height: 135)
   }
}



//MARK: - SearchBar Extension

extension PhotoViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var searchTerm = searchBar.text ?? ""
        searchTerm = searchTerm.lowercased().replacingOccurrences(of: " ", with: "+")
        loadSearch(str: searchTerm)
        print(searchTerm)
    }
}

