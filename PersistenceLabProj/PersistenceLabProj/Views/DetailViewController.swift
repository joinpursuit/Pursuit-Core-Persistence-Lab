//
//  DetailViewController.swift
//  PersistenceLabProj
//
//  Created by Kevin Natera on 10/1/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var pic: Photo!
    
    @IBOutlet weak var picImageOutlet: UIImageView!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        let favoritedPic = pic!
                DispatchQueue.global(qos: .utility).async {
                    try? FavoritesPersistenceHelper.manager.save(favoritePhoto: favoritedPic)
                    DispatchQueue.main.async {
                        print("saved")
                        self.navigationController?.popViewController(animated: true)
                    }
                }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    

    private func loadData() {
        viewsLabel.text = "\(pic.views)"
        likesLabel.text = "\(pic.likes)"
        commentsLabel.text = "\(pic.comments)"
        
        ImageHelper.shared.getImage(urlStr: pic.webformatURL) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let image):
                    self.picImageOutlet.image = image
                }
            }
        }
    }

}
