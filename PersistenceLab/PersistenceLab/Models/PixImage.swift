//
//  PixImage.swift
//  PersistenceLab
//
//  Created by Cameron Rivera on 1/16/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import Foundation

struct Wrapper: Codable{
    let hits: [PixPhoto]
}

struct PixPhoto: Codable, Equatable{
    var largeImageURL: String
    var likes: Int
    var user: String?
    var favorites: Int
    var tags: String
    var previewURL: String
    var webformatURL: String
}
