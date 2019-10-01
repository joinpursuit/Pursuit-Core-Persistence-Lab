//
//  Photo.swift
//  Persistence Lab
//
//  Created by Michelle Cueva on 9/30/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import Foundation

struct PhotoWrapper: Codable {
    let hits: [Photo]
}

struct Photo: Codable {
    let webformatURL: String
    let likes: Int
    let comments: Int
    
    static func decodePhotoFromData(from jsondata: Data) throws -> [Photo] {
        let response = try JSONDecoder().decode(PhotoWrapper.self, from: jsondata)
        return response.hits
    }
    
}
