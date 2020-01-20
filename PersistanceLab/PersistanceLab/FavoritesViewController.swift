//
//  FavoritesViewController.swift
//  PersistanceLab
//
//  Created by Liubov Kaper  on 1/19/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var faveImages = [Hit]()
    
    var isEditingTableView = false {
      didSet { // property observer
        // toggle editing mode of table view
        tableView.isEditing = isEditingTableView
        
        // toggle bar button item's title between "Edit" and "Done"
        navigationItem.leftBarButtonItem?.title = isEditingTableView ? "Done" : "Edit"
      }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        loadImages()
    }
    
   // opens saved data when the appis opened
    private func loadImages() {
        do {
            faveImages = try PersistanceHelper.loadImages()
        } catch {
            print("error loading images : \(error)" )
        }
    }
    
     //this function deletes permenantly
    private func deleteImage(indexPath: IndexPath) {
        do {
           try PersistanceHelper.delete(image: indexPath.row)
        } catch {
          print("error deleting event \(error)")
        }
    }
    
    @IBAction func addFaveImages(segue: UIStoryboardSegue) {
        guard let detailViewController = segue.source as?  DetailViewController, let addedImage = detailViewController.imageInfo else {
            fatalError("failed to access DetailViewController")
        }
        
        // this persists(saves) imageinfo to documents directory
        do {
            try PersistanceHelper.save(image: addedImage)
        } catch {
             print("error saving image with error: \(error)")
        }
       // faveImages.insert(addedImage, at: 0)
        faveImages.append(addedImage)
        
      //  let indexPath = IndexPath.self(row: faveImages.count - 1, section: 0)
        
       // tableView.insertRows(at: [indexPath], with: .automatic)
       // tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           guard let detailVC = segue.destination as? DetailViewController, let indexPath = tableView.indexPath(for: sender as! FavoritesCell) else {
               fatalError("error")
           }
           let image = faveImages[indexPath.row]
           detailVC.imageInfo = image
       }
    
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        
        isEditingTableView.toggle()
    }
    
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        faveImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoritesCell", for: indexPath) as? FavoritesCell else {
            fatalError("could not downcast to FavoritesCell")
        }
        let favImage = faveImages[indexPath.row]
        cell.configureTableViewCell(for: favImage)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .insert:
            print("inserting ...")
        case .delete:
            print("deleting...")
            faveImages.remove(at: indexPath.row)
            //this function deletes permenantly
            deleteImage(indexPath: indexPath)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        default:
            print("...")
        }
    }
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
