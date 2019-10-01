//
//  FavoritesDetailViewController.swift
//  Persistence Lab
//
//  Created by Michelle Cueva on 9/30/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit

class FavoritesDetailViewController: UIViewController {
    
    @IBOutlet weak var favoriteImage: UIImageView!
    
    @IBOutlet weak var likesLabel: UILabel!
    
    @IBOutlet weak var commentsLabel: UILabel!
    
    var favorite: Photo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getImage()
        configureLabels()
    }
    
    private func configureLabels() {
        likesLabel.text = favorite.likes.description
        commentsLabel.text = favorite.comments.description
    }
    
    private func getImage() {
        
        ImageHelper.shared.getImage(urlStr: favorite.webformatURL) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let imageFromOnline):
                    self.favoriteImage.image = imageFromOnline
                    
                case .failure( let error):
                    print(error)
                }
            }
        }
        
    }
    
}
