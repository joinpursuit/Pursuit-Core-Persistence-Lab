//
//  DetailViewController.swift
//  Persistance Lab
//
//  Created by Tsering Lama on 1/19/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit
import ImageKit
import DataPersistence

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var views: UILabel!
    @IBOutlet weak var downloads: UILabel!
    @IBOutlet weak var favButton: UIBarButtonItem!
    
    var photos: Things!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        detailImage.getImage(with: photos.largeImageURL) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
            case .success(let image):
                DispatchQueue.main.async {
                    self?.detailImage.image = image
                }
            }
        }
        
        likes.text = "Likes: \(photos.likes.description)"
        views.text = "Views: \(photos.views.description)"
        downloads.text = "Downloads: \(photos.downloads.description)"
        
    }
    
    @IBAction func favPressed(_ sender: Any) {
        guard let setFav = photos else {
            showAlert(title: "Error", message: "Couldnt favorite the photo")
            return
        }
        
        do {
            try PersistenceHelper.savePhotos(item: setFav)
            showAlert(title: "Success", message: "Save sucess")
        } catch {
            showAlert(title: "Error", message: "\(error)")
        }
    }
    

}
