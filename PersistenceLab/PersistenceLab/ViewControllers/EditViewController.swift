//
//  EditViewController.swift
//  PersistenceLab
//
//  Created by Cameron Rivera on 1/20/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var tagsTextField: UITextField!
    
    // MARK: Properties
    var indexOfCurrentPicture: Int?
    var persistenceHandler = PersistenceHelper<PixPhoto>(fileName: "Favourites Pictures")
    var savedPictures = [PixPhoto]()
    
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    // MARK: Helper Methods
    private func setUp(){
        userTextField.delegate = self
        tagsTextField.delegate = self
    }
    
    // MARK: Actions
    // Replaces the back button
    // Changes the fields if there is valid data to overwrite them.
    @IBAction func editingComplete(_ sender: UIBarButtonItem){
        guard let index = indexOfCurrentPicture else {
            fatalError("Could not find index of current picture.")
        }
        do {
            savedPictures = try persistenceHandler.getObjects()
            
            if let newTags = tagsTextField.text{
                if newTags != "" {
                    savedPictures[index].tags = newTags
                }
            }
            
            if let newUser = userTextField.text{
                if newUser != "" {
                    savedPictures[index].user = newUser
                }
            }
            
            try persistenceHandler.saveObjects(savedPictures)
        } catch {
            showAlert("Save Error", "Could not save edited data: \(error).")
        }
        navigationController?.popViewController(animated: true)
    }
}

// MARK: UITextFieldDelegate Methods
extension EditViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
