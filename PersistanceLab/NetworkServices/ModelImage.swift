//
//  AppError.swift
//  PersistanceLab
//
//  Created by Liubov Kaper  on 1/18/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import Foundation

struct Image: Codable {
    let hits: [Hit]
}

struct Hit: Codable {
    let largeImageURL: String
    let likes: Int
    let views: Int
    let comments: Int
    let pageURL: String
    let webformatURL: String // smaller image
    let tags: String
    let downloads: String
    let user: String
    let favorites: Int
    let userImageURL: String
    let previewURL: String// very small in=mage
}
