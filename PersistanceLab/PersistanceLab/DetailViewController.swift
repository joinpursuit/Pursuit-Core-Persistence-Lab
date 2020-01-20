//
//  DetailViewController.swift
//  PersistanceLab
//
//  Created by Liubov Kaper  on 1/19/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var userLabel: UILabel!
    
    @IBOutlet weak var tagsLabel: UILabel!
    
    
    @IBOutlet weak var likesLabel: UILabel!
    
    
    @IBOutlet weak var favoritesLabel: UILabel!
    
    var imageInfo: Hit?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
       
    }
    
    func updateUI() {
        guard let image = imageInfo else {
            fatalError("check prepare for segue")
        }
        userLabel.text = "user: \(image.user ?? "no name available")"
        tagsLabel.text = image.tags
        likesLabel.text = "likes: \(image.likes?.description ?? "")"
        favoritesLabel.text = "favorited by \(image.favorites?.description ?? "0") users"
        
        imageView.getImage(with: image.largeImageURL ?? "") { (result) in
                   switch result {
                   case .failure(let appError):
                       print("error: \(appError)")
                   case .success(let image):
                       DispatchQueue.main.async {
                           self.imageView.image = image
                       }
                   }
               }
        
    }
    

    @IBAction func addToFavorites(_ sender: UIBarButtonItem) {
        
        sender.isEnabled = false
        
//        guard let favImage = imageInfo else {
//            fatalError("error")
//        }
//
//        let favoritePost = Hit(largeImageURL: favImage.largeImageURL, likes: favImage.likes, views: favImage.views, comments: favImage.comments, pageURL: favImage.pageURL, webformatURL: favImage.webformatURL, tags: favImage.tags, downloads: favImage.downloads, user: favImage.user, favorites: favImage.favorites, userImageURL: favImage.userImageURL, previewURL: favImage.previewURL)
    }
    
    
}
