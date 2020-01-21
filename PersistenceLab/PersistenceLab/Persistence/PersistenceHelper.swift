//
//  PersistenceHelper.swift
//  PersistenceLab
//
//  Created by Cameron Rivera on 1/16/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import Foundation

// Refactor the delete to take in an integer corresponding to its place in the array. 
struct PersistenceHelper<T: Codable & Equatable>{

    // Reads the objects stored in the given file of the user's device. 
    func getObjects() throws -> [T]{
        guard let data = FileManager.default.contents(atPath: url.path) else {
            return []
        }
        return try PropertyListDecoder().decode([T].self, from: data)
    }
    
    // Creates a new object, and saves it to the user's device.
    func addObject(_ object: T) throws {
        var savedData = try getObjects()
        savedData.append(object)
        try saveObjects(savedData)
    }
    
    // Removes an object from the local device's storage.
    func removeObject(_ index: Int) throws {
        var savedData = try getObjects()
        savedData.remove(at: index)
        try saveObjects(savedData)
    }
    
    // Serializes and writes data to the local device
    func saveObjects(_ objArr: [T]) throws {
        let serializedData = try PropertyListEncoder().encode(objArr)
        try serializedData.write(to: url, options: Data.WritingOptions.atomic)
    }
    
    // Initializer for PersistenceHelper
    init(fileName: String){
        self.fileName = fileName
    }
    
    // The name of the file to save to.
    private var fileName: String
    
    // The path to a given file.
    private var url: URL {
        return filePathFromDocumentsDirectory(fileName)
    }
    
    // Returns the path to the documents directory on the user's device.
    private func documentsDirectory() -> URL{
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    // Returns a path to a file given as "filename"
    private func filePathFromDocumentsDirectory(_ filename: String) -> URL {
        return documentsDirectory().appendingPathComponent(filename)
    }
}
