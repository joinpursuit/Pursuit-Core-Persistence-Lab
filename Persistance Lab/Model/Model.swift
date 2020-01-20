//
//  Model.swift
//  Persistance Lab
//
//  Created by Tsering Lama on 1/19/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import Foundation

struct Pixabay: Codable {
    let hits: [Things]
}

struct Things: Codable, Equatable {
    let largeImageURL: String
    let likes: Int
    let views: Int
    let pageURL: String
    let downloads: Int
}
