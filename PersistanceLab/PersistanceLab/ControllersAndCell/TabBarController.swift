//
//  TabBarController.swift
//  PersistanceLab
//
//  Created by Yuliia Engman on 2/10/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import UIKit
import DataPersistence

class TabBarController: UITabBarController {
    
    private var dataPersistence = DataPersistence<Hit>(filename: "savedPicturesOfChoice.plist")
    
    private lazy var searchPicsNavController: UINavigationController = {
        guard let navController = storyboard?.instantiateViewController(identifier: "SearchPicsNavController") as? UINavigationController,
            let searchPicsViewController = navController.viewControllers.first as? SearchPicsViewController else {
                fatalError("could not load navController")
        }
        searchPicsViewController.dataPersistence = dataPersistence
        return navController
    }()
    
    private lazy var favoriteNavController: UINavigationController = {
           guard let navController = storyboard?.instantiateViewController(identifier: "FavoriteNavController") as? UINavigationController,
               let favoritePicturesViewController = navController.viewControllers.first as? FavoritePicturesViewController else {
                   fatalError("could not load navController")
           }
           favoritePicturesViewController.dataPersistence = dataPersistence
        favoritePicturesViewController.dataPersistence.delegate = favoritePicturesViewController
           return navController
       }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [searchPicsNavController, favoriteNavController]
    }
}


