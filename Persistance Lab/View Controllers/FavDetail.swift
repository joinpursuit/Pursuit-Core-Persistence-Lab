//
//  FavDetail.swift
//  Persistance Lab
//
//  Created by Tsering Lama on 1/19/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit

class FavDetail: UIViewController {

    @IBOutlet weak var favPhoto: UIImageView!
    @IBOutlet weak var views: UILabel!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var downloads: UILabel!
    
    var fav: Things!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        favPhoto.getImage(with: fav.largeImageURL) { [weak self](result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
            case .success(let image):
                DispatchQueue.main.async {
                    self?.favPhoto.image = image
                }
            }
        }
        
        likes.text = "Likes: \(fav.likes.description)"
        views.text = "Views: \(fav.views.description)"
        downloads.text = "Downloads: \(fav.downloads.description)"
    }
    
    @IBAction func deleteFav(_ sender: UIBarButtonItem) {
        
    }
    


}
