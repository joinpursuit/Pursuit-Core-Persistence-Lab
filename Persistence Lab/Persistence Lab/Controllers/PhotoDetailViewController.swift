//
//  PhotoDetailViewController.swift
//  Persistence Lab
//
//  Created by Michelle Cueva on 9/30/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    
    
    @IBOutlet weak var photoImage: UIImageView!
    
    var photo: Photo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getImage()
    }
    
    
    @IBAction func saveToFavorite(_ sender: UIButton) {
        let newPhoto = Photo(webformatURL: photo.webformatURL, likes: photo.likes, comments: photo.comments)
        
        DispatchQueue.global(qos: .utility).async {
            try? PhotoPersistenceHelper.manager.save(newPhoto: newPhoto)
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    private func getImage() {
        
        ImageHelper.shared.getImage(urlStr: photo.webformatURL) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let imageFromOnline):
                    self.photoImage.image = imageFromOnline
                    
                case .failure( let error):
                    print(error)
                }
            }
        }
        
    }
    
}
