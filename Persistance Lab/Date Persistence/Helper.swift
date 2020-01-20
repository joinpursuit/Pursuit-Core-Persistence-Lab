//
//  Helper.swift
//  Persistance Lab
//
//  Created by Tsering Lama on 1/19/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import Foundation

enum DataPersistenceError: Error {
    case savingError(Error) // associated value
    case decodingError(Error)
    case fileDoesntExist(String)
    case noData
    case deleteFailed(Error)
}

class PersistenceHelper {
    private static var photos = [Things]()
    private static let filename = "fav.plist"
    
    private static func save() throws {
        let url = FileManager.pathFromDocumentsDirectory(filename: filename)
        do {
            let data = try PropertyListEncoder().encode(photos)
            try data.write(to: url, options: .atomic)
        } catch {
            throw DataPersistenceError.savingError(error)
        }
    }
    
    static func savePhotos(item: Things) throws {
        photos.append(item)
        
        do {
            try save()
        } catch {
            throw DataPersistenceError.savingError(error)
        }
    }
    
    static func loadPhotos() throws -> [Things] {
        let url = FileManager.pathFromDocumentsDirectory(filename: filename)
        if FileManager.default.fileExists(atPath: url.path) {
            if let data = FileManager.default.contents(atPath: url.path) {
                do {
                    photos = try PropertyListDecoder().decode([Things].self, from: data)
                } catch {
                    throw DataPersistenceError.decodingError(error)
                }
            } else {
                throw DataPersistenceError.noData
            }
        } else {
            throw DataPersistenceError.fileDoesntExist(filename)
        }
        return photos
    }
    
    static func deletePic(index: Int) throws {
        photos.remove(at: index)
        
        do {
            try save()
        } catch {
            throw DataPersistenceError.deleteFailed(error)
        }
    }
}
