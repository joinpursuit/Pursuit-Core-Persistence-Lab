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
            // print("there \(savedPictures.count) saved pictures")
            DispatchQueue.main.async {
                self.tableView.reloadData()
                // self.fetchSavedPictures()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        navigationItem.title = "Favorited Pictures"
        
        //viewWillAppear(_, animated: true)
        //fetchSavedPictures()
    }
    
    //Actually never called this func:
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchSavedPictures()
    }
    
    func fetchSavedPictures() {
        do {
            savedPictures = try dataPersistance.loadItems().reversed()
        } catch {
            print("error fetching articles: \(error)")
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension FavoritePicturesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // FIXME - return pictures.count
        return savedPictures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoritePictureCell", for: indexPath) as? FavoritePictureCell else {
            fatalError("could not deque to FavoritePictureCell")
        }
        //FIXME: do I need to configure cell if I will use dataPersistance?
        let favoritePicture = savedPictures[indexPath.row]
        cell.configureCell(for: favoritePicture)
        return cell
    }
}

extension FavoritePicturesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
}

extension FavoritePicturesViewController: DataPersistenceDelegate {
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        print("item was saved")
        // fetchSavedPictures() // using it to test
    }
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        print("item was deleted")
    }
}

