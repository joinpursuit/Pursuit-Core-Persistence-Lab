//
//  DetailedController.swift
//  PersistenceLab
//
//  Created by Cameron Rivera on 1/16/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit

class DetailedController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var favouritesLabel: UILabel!
    
    var currentPicture: PixPhoto?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp(){
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")
        navigationItem.rightBarButtonItem?.title = ""
        
        guard let curPic = currentPicture else {
            showAlert("Loading Error", "Could not retrieve data.")
            return
        }
        tagsLabel.text = "Tags: \(curPic.tags)"
        likesLabel.text = "Likes: \(curPic.likes)"
        favouritesLabel.text = "Favourites: \(curPic.favorites)"
        
        imageView.getImage(curPic.largeImageURL) { [weak self] result in
            switch result{
            case .failure(let netError):
                DispatchQueue.main.async{
                    self?.showAlert("Loading Error", "Could not retrieve image: \(netError)")
                }
            case .success(let image):
                DispatchQueue.main.async{
                    self?.imageView.image = image
                }
            }
        }
        
    }
    
    @IBAction func favouritedPicture(_ sender: UIBarButtonItem){
        guard let curPic = currentPicture else {
            showAlert("Save Error", "Could not save photo to device.")
            return
        }
        
        let persistenceHelper = PersistenceHelper<PixPhoto>(fileName: "Favourites Pictures")
        
        do{
            try persistenceHelper.saveObjects(curPic)
            showAlert("Success", "Successfully saved picture to device")
        } catch {
            showAlert("Error", "\(error)")
        }
    }
    
}
