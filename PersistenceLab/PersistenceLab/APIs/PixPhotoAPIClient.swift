//
//  PixPhotoAPIClient.swift
//  PersistenceLab
//
//  Created by Cameron Rivera on 1/16/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import Foundation

struct PixPhotoAPIClient {
    static func getObject(_ urlString: String, completion: @escaping (Result<[PixPhoto],NetworkError>) -> ()) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL(urlString)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(request) { result in
            switch result{
            case .failure(let netError):
                completion(.failure(.networkClientError(netError)))
            case .success(let data):
                do {
                    let pics = try JSONDecoder().decode(Wrapper.self, from: data)
                    completion(.success(pics.hits))
                } catch{
                    completion(.failure(.encodingError(error)))
                }
            }
        }
    }
    
    static func getPixURL(_ query: String) -> String{
        let searchQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "wolves"
        return "https://pixabay.com/api/?key=\(Keys.apiKey)&q=\(searchQuery)"
    }
}
