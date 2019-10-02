//
//  PhotoStruct.swift
//  PersistenceLabProj
//
//  Created by Kevin Natera on 10/1/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import Foundation


struct PhotoWrapper : Codable {
    let hits: [Photo]
}

struct Photo : Codable {
    let webformatURL: String
    let likes: Int
    let views: Int
    let comments: Int
}
