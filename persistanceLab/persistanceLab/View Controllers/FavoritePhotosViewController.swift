//
//  FavoritesViewController.swift
//  persistanceLab
//
//  Created by Sam Roman on 9/30/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit

class FavoritePhotosViewController: UIViewController {

    var favs = [FavPhotos]()
    
    @IBOutlet weak var favTableView: UITableView!
    
    override func viewDidLoad() {
        favTableView.delegate = self
        favTableView.dataSource = self
        loadData()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    




 func loadData(){
        do {
           favs = try PhotoPersistenceHelper.manager.getPhoto()
        } catch {
            print(error)
        }
    }

}



extension FavoritePhotosViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favs.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 335
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let fav = favs[indexPath.row]
        guard let cell = favTableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as? FavPhotosTableViewCell else { return UITableViewCell() }
        ImageHelper.shared.fetchImage(urlString: fav.largeImageURL) { (result) in
            DispatchQueue.main.async {
                switch result{
                case .success(let image):
                    cell.favPhoto.image = image
                case .failure(let error):
                    print(error)
                    cell.favPhoto.image = UIImage(named: "placeholder")
                }
            }
        }
        return cell
        
    }
    
    
}
