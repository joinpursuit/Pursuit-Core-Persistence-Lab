//
//  PictureSearchAPI.swift
//  PersistanceLab
//
//  Created by Yuliia Engman on 1/27/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import Foundation
import NetworkHelper

struct PictureSearchAPIClient {
    static func fetchPicture(for searchQuery: String, completion: @escaping(Result<[Hit], AppError>) -> ()) {
        let searchQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "uk"
        
        let pictureEndpointURL = "https://pixabay.com/api/?key=\(SecretKey.apikey)&q=\(searchQuery)&image_type=photo"
        
        guard let url = URL(string: pictureEndpointURL) else {
        completion(.failure(.badURL(pictureEndpointURL)))
            return
        }
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) {(result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let searchResults = try JSONDecoder().decode([Hit].self, from: data)
                    
                  // Add how to map through countries
                    //let countries = searchResults.ma
                    completion(.success(searchResults))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
            
        }
    }
}

//
//struct CreperieAPIClient {
//    static func fetchCreperie(completion: @escaping (Result<[Business], AppError>) -> ()) {
//
//        let businessEndpointURL = "https://api.yelp.com/v3/businesses/search?term=creperie&limit=50&location=quebec"
//
//        guard let url = URL(string: businessEndpointURL) else {
//    completion(.failure(.badURL(businessEndpointURL)))
//            return
//        }
//        var request = URLRequest(url: url)
//
//        request.httpMethod = "GET"
//
//        request.addValue("Bearer \(SecretKey.apikey)", forHTTPHeaderField: "Authorization")
//
//        NetworkHelper.shared.performDataTask(with: request) {(result) in
//            switch result {
//            case .failure(let appError):
//                completion(.failure(.networkClientError(appError)))
//            case .success(let data):
//                do {
//                    let creperie = try JSONDecoder().decode(Creperie.self, from: data)
//
//                    completion(.success(creperie.businesses))
//                } catch {
//                    completion(.failure(.decodingError(error)))
//                }
//            }
//        }
//    }
//}
