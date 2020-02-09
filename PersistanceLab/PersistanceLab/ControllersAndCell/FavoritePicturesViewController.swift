//
//  ViewController.swift
//  PersistanceLab
//
//  Created by Yuliia Engman on 1/21/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import UIKit
import DataPersistence
import ImageKit

class FavoritePicturesViewController: UIViewController {
    
    public var dataPersistance: DataPersistence<Hit>!
    
    @IBOutlet weak var tableView: UITableView!
    
    private var savedPictures = [Hit]() {
        didSet {
            print("there \(savedPictures.count) saved pictures")
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        navigationItem.title = "Favorited Pictures"
    }
}

extension FavoritePicturesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // FIXME - return pictures.count
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoritePictureCell", for: indexPath) as? FavoritePictureCell else {
            fatalError("could not deque to FavoritePictureCell")
        }
        //FIXME: do I need to configure cell if I will use dataPersistance?
        //let favoritePicture = savedPictures[indexPath.row]
       // cell.configureCell(for: favoritePicture)
        return cell
    }
}

extension FavoritePicturesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
}

//
//import UIKit
//import DataPersistence
//
//class FavoriteController: UIViewController {
//
//    public var dataPersistance: DataPersistence<Hit>!
//
//    @IBOutlet weak var tableView: UITableView!
//
//    // Conforming to the DataPersistanceDelegate - Step 1
//    private var savedPictures = [Hit]() {
//        didSet {
//            print("there are \(savedPictures.count) pictures")
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .systemPink
//
//        tableView.dataSource = self
//        tableView.delegate = self
//
//        fetchSavedPictures()
//        navigationItem.title = "Favorited Pictures"
//
//
//        // FIXME: I register here tableView cell, but I think I need to create tableView on FavoriteView.swift (look how did we do with collection view)
//        // tableView.register(UINib(nibName: "FavoriteImageCell", bundle: nil), forCellReuseIdentifier: "favoriteImageCell")))
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        fetchSavedPictures()
//    }
//
//
//    // Conforming to the DataPersistanceDelegate - Step 2
//    private func fetchSavedPictures() {
//        do {
//            savedPictures = try dataPersistance.loadItems().reversed()
//
//        } catch {
//            print("error fetching articles: \(error)")
//        }
//    }
//}
//
//extension FavoriteController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // FIXME: return saved pictures
//        return savedPictures.count
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoritePictureCell", for: indexPath) as? FavoritePictureCell else {
//            fatalError("failed to deque an FavoritePictureCell")
//        }
//
//        let favoritePic = savedPictures[indexPath.row]
//        // configure the cell
//        cell.configureCell(for: favoritePic)
//
//        return cell
//    }
//}
//
//extension FavoriteController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 275
//    }
//}
//
//extension FavoriteController: DataPersistenceDelegate {
//    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
//        print("picture was saved")
//        //fetchSavedPictures()
//    }
//
//    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
//        print("item was dleted")
//    }
//}

