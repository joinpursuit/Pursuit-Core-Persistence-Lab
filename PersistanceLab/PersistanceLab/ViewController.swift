//
//  ViewController.swift
//  PersistanceLab
//
//  Created by Liubov Kaper  on 1/18/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
   
    
   
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
   
    
    private var images = [Hit]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImages(searchQuary: "")
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        
    }


    private func fetchImages(searchQuary: String) {
        ImageAPIClient.getAllImageInfo(for: searchQuary, completion: { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("could not fetch images with error \(appError)")
            case .success(let images):
                DispatchQueue.main.async {
                    self?.images = images.hits 
                }
                
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController, let indexPath = collectionView.indexPath(for: sender as! ImageCollectionViewCell) else {
            fatalError("error")
        }
        let image = images[indexPath.row]
        detailVC.imageInfo = image
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ImageCollectionViewCell else {
            fatalError("could not downcast to imageCell")
        }
        let image = images[indexPath.row]
        cell.configureCollectionViewCell(for: image)
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let interItemSpacing:CGFloat = 5 // space between items
        let maxWidth = UIScreen.main.bounds.size.width // device's width
        let numberOfItems: CGFloat = 1 // 3 items
        let totalSpacing: CGFloat = numberOfItems * interItemSpacing
        let itemWidth:CGFloat = (maxWidth - totalSpacing) / numberOfItems
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 5, bottom: 1, right: 5)
    }
    // by defayult this is 10
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let search = searchBar.text else {
            print("missing search text")
            return
        }
      fetchImages(searchQuary: search)
    }
}
