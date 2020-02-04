//
//  DetailViewController.swift
//  fileManagerProject
//
//  Created by Ahad Islam on 1/27/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    public var pix: Pix!
    private var favoritedPix = [Pix]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        // Do any additional setup after loading the view.
    }
    
    private func configureView() {
        userLabel.text = pix.user
        tagsLabel.text = pix.tags
        likesLabel.text = "\(pix.likes)"
        imageView.getImage(with: pix.webformatURL) { [weak self] result in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(systemName: "exclamationmark.triangle")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            }
        }
        
        do {
            favoritedPix = try PixPersistenceHelper.manager.getPix()
        } catch {
            print(error)
        }
    }
    
    @IBAction func buttonPressed(_ sender: UIBarButtonItem) {
        let alertVC = UIAlertController(title: "Error", message: "Item has already been saved", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        if !favoritedPix.contains(pix) {
            do {
                try PixPersistenceHelper.manager.save(newPix: pix)
            } catch {
                print(error)
            }
        } else {
            present(alertVC, animated: true, completion: nil)
        }
        
        sender.isEnabled = false
        sender.image = UIImage(systemName: "heart.fill")
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
