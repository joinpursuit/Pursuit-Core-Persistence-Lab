//
//  Pix.swift
//  fileManagerProject
//
//  Created by Ahad Islam on 1/27/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import Foundation

struct PixWrapper: Codable {
    let hits: [Pix]
}

struct Pix: Codable {
    // likes, favorites, tags, previewURL, webformatURL
    let likes: Int
    let tags: String
    let previewURL: String
    let webformatURL: String
}
