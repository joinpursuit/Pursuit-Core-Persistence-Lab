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
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var favouritesLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    var currentPicture: PixPhoto?
    var currentPictureIndex: Int?
    var persistenceHandler = PersistenceHelper<PixPhoto>(fileName: "Favourites Pictures")
    var seguedFromFavourites = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
         setUp()
    }
    
    private func setUp(){
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")
        navigationItem.rightBarButtonItem?.title = ""
    
        if seguedFromFavourites {
            editButton.setTitle("Edit", for: .normal)
            do {
                guard let index = currentPictureIndex else {
                    fatalError("Could not obtain index of current photo")
                }
                
                let savedPhotos = try persistenceHandler.getObjects()
                currentPicture = savedPhotos[index]
                
            } catch {
                showAlert("Retrieval Error", "Could not retrieve saved pictures: \(error)")
            }
            
        } else {
            editButton.isHidden = true
            editButton.isEnabled = false
        }
        
        guard let curPic = currentPicture else {
            showAlert("Loading Error", "Could not retrieve data.")
            return
        }
        
        tagsLabel.text = "Tags: \(curPic.tags)"
        userLabel.text = "User: \(curPic.user ?? "N/A")"
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
        guard let curPic = currentPicture, let index = currentPictureIndex else {
            showAlert("Save Error", "Could not save photo to device.")
            return
        }
        
        let persistenceHelper = PersistenceHelper<PixPhoto>(fileName: "Favourites Pictures")
        
        do{
            if try persistenceHelper.getObjects().contains(curPic){
                try persistenceHelper.removeObject(index)
                showAlert("Notice", "Picture was successfully removed from favourites.")
            } else {
                try persistenceHelper.addObject(curPic)
                showAlert("Success", "Successfully saved picture to device")
            }
        } catch {
            showAlert("Error", "\(error)")
        }
    }
    
    @IBAction func editPicture(_ sender: UIButton){
        guard let editVC = storyboard?.instantiateViewController(identifier: "EditViewController") as? EditViewController else {
            fatalError("Could not successfully segue from detailed View Controller")
        }
        editVC.indexOfCurrentPicture = currentPictureIndex
        navigationController?.pushViewController(editVC, animated: true)
    }
    
}
