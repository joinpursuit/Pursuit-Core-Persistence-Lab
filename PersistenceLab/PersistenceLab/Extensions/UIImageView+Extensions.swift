//
//  UIImageView+Extensions.swift
//  PersistenceLab
//
//  Created by Cameron Rivera on 1/16/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit

// Queries an endpoint for an image.
extension UIImageView{
    func getImage(_ imageURL: String, completion: @escaping (Result<UIImage, NetworkError>) -> ()) {
        
        guard let url = URL(string: imageURL) else {
            completion(.failure(.badURL(imageURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(request) { result in
            switch result {
            case .failure(let netError):
                completion(.failure(.networkClientError(netError)))
            case .success(let data):
                if let image = UIImage(data: data) {
                    completion(.success(image))
                }
            }
        }
    }
}
