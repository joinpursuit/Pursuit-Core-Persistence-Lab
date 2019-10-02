//
//  FavoriteDetailViewController.swift
//  PersistenceLabProj
//
//  Created by Kevin Natera on 10/1/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import UIKit

class FavoriteDetailViewController: UIViewController {

    var favPic: Photo!
    
    @IBOutlet weak var fPicImageOutlet: UIImageView!
    @IBOutlet weak var fViewsLabel: UILabel!
    @IBOutlet weak var fLikesLabel: UILabel!
    @IBOutlet weak var fCommentsLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    private func loadData() {
           fViewsLabel.text = "\(favPic.views)"
           fLikesLabel.text = "\(favPic.likes)"
           fCommentsLabel.text = "\(favPic.comments)"
           
           ImageHelper.shared.getImage(urlStr: favPic.webformatURL) { (result) in
               DispatchQueue.main.async {
                   switch result {
                   case .failure(let error):
                       print(error)
                   case .success(let image):
                       self.fPicImageOutlet.image = image
                   }
               }
           }
       }

}
