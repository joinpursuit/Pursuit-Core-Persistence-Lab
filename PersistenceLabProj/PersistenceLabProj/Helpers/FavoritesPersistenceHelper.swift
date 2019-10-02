//
//  FavoritesPersistenceHelper.swift
//  PersistenceLabProj
//
//  Created by Kevin Natera on 10/2/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import Foundation


struct FavoritesPersistenceHelper {
    
    static let manager = FavoritesPersistenceHelper()

    func save(favoritePhoto: Photo) throws {
        try persistenceHelper.save(newElement: favoritePhoto)
    }

    func getFavorites() throws -> [Photo] {
        return try persistenceHelper.getObjects()
    }

    private let persistenceHelper = PersistenceHelper<Photo>(fileName: "favorites.plist")

    private init() {}
}
