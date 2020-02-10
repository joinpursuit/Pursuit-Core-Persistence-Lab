//
//  DetailViewController.swift
//  PersistanceLab
//
//  Created by Yuliia Engman on 1/23/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import UIKit
import DataPersistence
import ImageKit

class DetailViewController: UIViewController {
    
    public var dataPersistance: DataPersistence<Hit>!
    
    //public var picture: Hit?
    public var onePicture: Hit?
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var webformatURLLabel: UILabel!
    @IBOutlet weak var previewURLLabel: UILabel!
    
    @IBOutlet weak var favoriteBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    private func updateUI() {
        guard let onePicture = onePicture else {
            fatalError("did not load data from segue")
        }
        tagsLabel.text = "Tags: \(onePicture.tags)"
        likesLabel.text = "Likes: \(String(onePicture.likes))"
        favoriteLabel.text = "Favorite: \(String(onePicture.favorites))"
        webformatURLLabel.text = "WebformatURL: \(onePicture.webformatURL)"
        previewURLLabel.text = "PreviewURL: \(onePicture.previewURL)"
        
        detailImage.getImage(with: onePicture.largeImageURL) {
            [weak self] (result) in
            switch result {
            case .failure:
                print("could not load picture")
            case .success(let picture):
                DispatchQueue.main.async {
                    self?.detailImage.image = picture
                }
            }
        }
    }
    
    @IBAction func savedPicturePressed(_ sender: UIBarButtonItem) {
        
        print("saved article button pressed")
        guard let favoritedPicture = onePicture else { return }
        let favorited = Hit(largeImageURL: favoritedPicture.largeImageURL, likes: favoritedPicture.likes, webformatURL: favoritedPicture.webformatURL, tags: favoritedPicture.tags, favorites: favoritedPicture.favorites, previewURL: favoritedPicture.previewURL)
        do {
            //SAVING TO DOCUMENT DIRECTORY
            try dataPersistance.createItem(favorited)
        } catch {
            print("error saving article: \(error)")
        }
    }
}



