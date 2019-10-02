 //
//  PhotoAPIHelper.swift
//  PersistenceLabProj
//
//  Created by Kevin Natera on 10/1/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import Foundation

class PhotoAPIHelper {
    private init() {}
    
    static let shared = PhotoAPIHelper()

    func getPhoto(query: String?,completionHandler: @escaping (Result<[Photo],AppError>) -> () ) {
        let urlStr = "https://pixabay.com/api/?key=\(Secrets.apiKey)&q=\(query ?? "")"
    guard let url = URL(string: urlStr) else {
        completionHandler(.failure(.badURL))
        return
    }
    
    NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
        switch result {
        case .failure(let error):
            print(error)
        case .success(let data):
            do {
                let photoInfo = try JSONDecoder().decode(PhotoWrapper.self, from: data)
                completionHandler(.success(photoInfo.hits))
            } catch {
                completionHandler(.failure(.couldNotParseJSON(rawError: error)))
            }
        }
    }
  }
}
