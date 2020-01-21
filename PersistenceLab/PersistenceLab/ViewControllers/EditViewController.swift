//
//  EditViewController.swift
//  PersistenceLab
//
//  Created by Cameron Rivera on 1/20/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var tagsTextField: UITextField!
    
    var indexOfCurrentPicture: Int?
    var persistenceHandler = PersistenceHelper<PixPhoto>(fileName: "Favourites Pictures")
    var savedPictures = [PixPhoto]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp(){
        userTextField.delegate = self
        tagsTextField.delegate = self
    }
    
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

extension EditViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
