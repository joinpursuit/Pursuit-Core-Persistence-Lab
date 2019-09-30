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

    func save(newPhoto: Photo) throws {
        try persistenceHelper.save(newElement: newPhoto)
    }

    func getPhoto() throws -> [Photo] {
        return try persistenceHelper.getObjects()
    }

    private let persistenceHelper = PersistenceHelper<Photo>(fileName: "photos.plist")

    private init() {}
}
