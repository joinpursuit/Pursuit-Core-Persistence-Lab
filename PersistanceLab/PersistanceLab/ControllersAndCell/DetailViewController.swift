//
//  DetailViewController.swift
//  PersistanceLab
//
//  Created by Yuliia Engman on 1/23/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var webformatURLLabel: UILabel!
    @IBOutlet weak var previewURLLabel: UILabel!
    
    @IBOutlet weak var favoriteBarButton: UIBarButtonItem!
    
    
    var onePicture: Hit?
    
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
}



