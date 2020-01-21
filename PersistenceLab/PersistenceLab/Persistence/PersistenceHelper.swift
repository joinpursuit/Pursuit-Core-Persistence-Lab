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

    func getObjects() throws -> [T]{
        guard let data = FileManager.default.contents(atPath: url.path) else {
            return []
        }
        return try PropertyListDecoder().decode([T].self, from: data)
    }
    
    func addObject(_ object: T) throws {
        var savedData = try getObjects()
        savedData.append(object)
        try saveObjects(savedData)
    }
    
    func removeObject(_ index: Int) throws {
        var savedData = try getObjects()
        savedData.remove(at: index)
        try saveObjects(savedData)
    }
    
    func saveObjects(_ objArr: [T]) throws {
        let serializedData = try PropertyListEncoder().encode(objArr)
        try serializedData.write(to: url, options: Data.WritingOptions.atomic)
    }
    
    init(fileName: String){
        self.fileName = fileName
    }
    
    private var fileName: String
    
    private var url: URL {
        return filePathFromDocumentsDirectory(fileName)
    }
    
    private func documentsDirectory() -> URL{
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    private func filePathFromDocumentsDirectory(_ filename: String) -> URL {
        return documentsDirectory().appendingPathComponent(filename)
    }
}
