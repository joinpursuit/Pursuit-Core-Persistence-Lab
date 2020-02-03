//
//  PixTableViewCell.swift
//  fileManagerProject
//
//  Created by Ahad Islam on 1/27/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import UIKit

class PixTableViewCell: UITableViewCell {

    @IBOutlet weak var pixImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configurePixImage(_ pix: Pix) {
        pixImageView.getImage(with: pix.previewURL) { [weak self] result in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.pixImageView.image = UIImage(systemName: "exclamationmark.triangle")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.pixImageView.image = image
                }
            }
        }
    }

}
