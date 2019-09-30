//
//  PhotoDetailViewController.swift
//  persistanceLab
//
//  Created by Sam Roman on 9/30/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit

class PhotoSearchDetailViewController: UIViewController {

    var photo: Hit?
    
    @IBOutlet weak var largeImage: UIImageView!
    
    
    @IBOutlet weak var addToFavorites: UIButton!
    
    
    @IBAction func addFav(_ sender: UIButton) {
        let fav = FavPhotos(largeImageURL: photo?.largeImageURL ?? "")
        DispatchQueue.global(qos: .utility).async {
          try? PhotoPersistenceHelper.manager.save(newPhoto: fav)
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
        
    }
    
    
    private func loadDetails(){
        ImageHelper.shared.fetchImage(urlString: photo!.largeImageURL) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.largeImage.image = image
                case .failure(let error):
                    self.largeImage.image = UIImage(named: "placeholder")
                }
            }
        }
        
    }
    
    
    override func viewDidLoad() {
        loadDetails()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
