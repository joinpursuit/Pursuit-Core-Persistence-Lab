//
//  FavCell.swift
//  Persistance Lab
//
//  Created by Tsering Lama on 1/19/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit
import ImageKit

protocol favCellDelegate: AnyObject {
    func didLongPress(cell: FavCell)
}

class FavCell: UICollectionViewCell {
    
    @IBOutlet weak var favPhoto: UIImageView!
    
    weak var delegate: favCellDelegate?
    
    private lazy var longPressedGesture: UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer()
        gesture.addTarget(self, action: #selector(longPressedAction(gesture:)))
        return gesture
    } ()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addGestureRecognizer(longPressedGesture)
    }
    
    @objc
    private func longPressedAction(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            gesture.state = .cancelled
            return
        }
        
        // step 3: creating custom delegate to notify any updates when user long presses
        delegate?.didLongPress(cell: self)  // imagesViewController.didLongPress
        
    }
    
    func configreCell(fav: Things) {
        favPhoto.getImage(with: fav.largeImageURL) { [weak self ](result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
            case .success(let image):
                DispatchQueue.main.async {
                    self?.favPhoto.image = image
                }
            }
        }
    }
    
}
