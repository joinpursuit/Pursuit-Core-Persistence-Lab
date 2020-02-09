//
//  DetailViewController.swift
//  PersistanceLab
//
//  Created by Yuliia Engman on 1/23/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var webformatURLLabel: UILabel!
    @IBOutlet weak var previewURLLabel: UILabel!
    
    var onePicture: Hit?

    override func viewDidLoad() {
        super.viewDidLoad()
    }


}
