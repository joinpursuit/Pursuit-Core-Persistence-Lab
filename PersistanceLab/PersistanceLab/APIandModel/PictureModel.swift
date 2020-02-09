//
//  PictureModel.swift
//  PersistanceLab
//
//  Created by Yuliia Engman on 1/27/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import Foundation

// MARK: - Photos
struct Photos: Codable & Equatable {
    let hits: [Hit]
}

// MARK: - Hit
struct Hit: Codable & Equatable {
    let largeImageURL: String
    let likes: Int
    let webformatURL: String
    let tags: String
    let favorites: Int
    let previewURL: String
}

