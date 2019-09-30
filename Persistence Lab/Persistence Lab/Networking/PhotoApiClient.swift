//
//  PhotoApiClient.swift
//  Persistence Lab
//
//  Created by Michelle Cueva on 9/30/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import Foundation

struct PhotoAPIClient {
    
    // MARK: - Static Properties
    
    static let manager = PhotoAPIClient()
    
    // MARK: - Instance Methods
    

    func getPhotosFromOnline(completionHandler: @escaping (Result<[Photo], AppError>) -> ())  {
        NetworkHelper.manager.performDataTask(withUrl: elementURL, andMethod: .get) { (results) in
            switch results {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let photoInfo = try Photo.decodePhotoFromData(from: data)
                    completionHandler(.success(photoInfo))
                }
                catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
                
            }
        }
    }
    
    
    // MARK: - Private Properties and Initializers
    private var elementURL: URL {
        guard let url = URL(string: "https://pixabay.com/api/?key=13796813-4829a9f0f397e0d08c42a6038&image_type=photo") else {
            fatalError("Error: Invalid URL")
        }
        return url
    }
    
    private init() {}
}
