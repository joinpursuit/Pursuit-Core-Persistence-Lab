//
//  SlothHelper.swift
//  sloth-app
//
//  Created by David Rifkin on 9/30/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

struct PhotoPersistenceHelper {
    static let manager = PhotoPersistenceHelper()

    func save(newPhoto: FavPhotos) throws {
        try persistenceHelper.save(newElement: newPhoto)
    }

    func getPhoto() throws -> [FavPhotos] {
        return try persistenceHelper.getObjects()
    }

    private let persistenceHelper = PersistenceHelper<FavPhotos>(fileName: "favorites.plist")

    private init() {}
}
