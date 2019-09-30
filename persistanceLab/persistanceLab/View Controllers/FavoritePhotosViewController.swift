//
//  FavoritesViewController.swift
//  persistanceLab
//
//  Created by Sam Roman on 9/30/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit

class FavoritePhotosViewController: UIViewController {

//    var favs = [Fav]()
    
    @IBOutlet weak var favTableView: UITableView!
    
    override func viewDidLoad() {
        favTableView.delegate = self
        favTableView.dataSource = self
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    




// func loadData(){
//        do {
//           favs = try PhotoPersistenceHelper.manager.getPhoto()
//        } catch {
//            print(error)
//        }
//    }
//
//}

}

extension FavoritePhotosViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
