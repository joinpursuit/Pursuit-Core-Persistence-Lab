//
//  ImageView+Extensions.swift
//  fileManagerProject
//
//  Created by Ahad Islam on 2/3/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import UIKit

extension UIImageView {
  func getImage(with urlString: String,
                completion: @escaping (Result<UIImage, AppError>) -> ()) {
    
    // The UIActivityIndicatorView is used to indicate to the user that a download is in progress
    let activityIndicator = UIActivityIndicatorView(style: .large)
    activityIndicator.color = .systemOrange
    activityIndicator.startAnimating() // it's hidden until we explicitly start animating
    activityIndicator.center = center
    addSubview(activityIndicator) // we add the indicattor as a subview of the image view
    
    guard let url = URL(string: urlString) else {
        completion(.failure(.badURL))
        return
    }
    
    NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { [weak activityIndicator] (result) in
      DispatchQueue.main.async {
        activityIndicator?.stopAnimating() // hides when we stop animating the indicator
      }
      switch result {
      case .failure(let appError):
        completion(.failure(.networkClientError(appError)))
      case .success(let data):
        if let image = UIImage(data: data) {
          completion(.success(image))
        }
      }
    }
  }
}
